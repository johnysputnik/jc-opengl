
(asdf:defsystem #:jc-opengl
  :description "jc-opengl - My opengl library"
  :version "0.0.1"
  :author "John Cumming <john@jsolutions.co.uk>"
  :licence "Public Domain"
  :depends-on (#:cl-opengl
               #:cl-glu
               #:cl-glut
               #:bordeaux-threads)
  :components ((:file "packages")
               (:file "main" :depends-on ("gl-core"))
               (:file "gl-core")))
