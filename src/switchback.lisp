(in-package :cl-user)
(defpackage switchback
  (:use :cl)
  (:import-from :jonathan
                :parse)
  (:import-from :cl-ppcre
                :all-matches-as-strings)
  (:export :parse-robots))

(in-package :switchback)

(defparameter *results* (make-hash-table :test 'equalp))

(defun sethash (entry)
    (when (null (nth-value 1 (gethash entry *results*)))
        (setf (gethash entry *results*) entry)
        (print entry)))

(defun get-robots (host)
    (let* ((query (concatenate 'string host "/robots.txt"))
           (url (quri:make-uri :defaults "https://web.archive.org/cdx/search/cdx"
                               :query `(("url" . ,query)
                                        ("output" . "json")
                                        ("fl" . "timestamp,original")
                                        ("filter" . "statuscode:200")
                                        ("collapse" . "digest"))))
           (response (cdr (parse (dex:get url)))))
        response))

(defun parse-robots (host)
    (let ((snapshots (get-robots host)))
        (if (null snapshots)
            (print "Nothing was found")
            (progn
                (loop for snapshot in snapshots do
                  (let* ((robots (dex:get (format nil "~a/~a/~a" "https://web.archive.org/web" (car snapshot) (cadr snapshot))))
                         (urls (all-matches-as-strings "Disallow: .*" robots)))
                          (loop for url in urls do
                            (sethash (string-trim '(#\^M) (string-trim "Disallow: " url))))))))))
