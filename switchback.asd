(defsystem "switchback"
  :version "0.1.0"
  :author "Walpurgisnatch"
  :license "MIT"
  :depends-on ("dexador"
               "plump"
               "clss")
  :components ((:module "src"
                :components
                ((:file "switchback"))))
  :description ""
  :in-order-to ((test-op (test-op "switchback/tests"))))
