(defsystem "switchback"
    :version "0.1.0"
    :author "Walpurgisnatch"
    :license "MIT"
    :depends-on ("dexador"
                 "jonathan"
                 "quri"
                 "cl-ppcre")
    :components ((:module "src"
                  :components
                  ((:file "switchback"))))
    :description "Fetch urls from Wayback Machine"
    :in-order-to ((test-op (test-op "switchback/tests"))))
