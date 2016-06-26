(in-package #:jc-opengl)

(require 'cl-opengl)
(require 'cL-glu)
(require 'cl-glut)


(defun gl-run ()

  (cffi:defcallback draw :void ()
    (gl:clear :color-buffer :depth-buffer)
    (draw-function)
    (glut:swap-buffers))

  (cffi:defcallback reshape :void ((width :int) (height :int))
    (let ((ratio (if (= height 0)
                     width
                     (/ (* 1.0 width) height))))
      (gl:viewport 0 0 width height)
      (gl:matrix-mode :projection)
      (gl:load-identity)
      (glu:perspective 50 ratio 1.0 10.0)
      (glu:look-at -2 1 4
                   0.5 0.5 0.5
                   0 1 0)
      ;;(glu:look-at 0 0 4
      ;;             0 0 0
      ;;             0 1 0)
      (gl:matrix-mode :modelview)
      (gl:load-identity)
      (reshape-function)))

  (cffi:defcallback key :void ((key :uchar) (x :int) (y :int))
    (declare (ignore x y))
    (key-function key)
    (glut:post-redisplay))

  (cffi:defcallback special :void ((key glut:special-keys) (x :int) (y :int))
    (declare (ignore x y))
    (special-function key)
    (glut:post-redisplay))

  (cffi:defcallback idle :void ()
    (glut:post-redisplay))

  (cffi:defcallback visible :void ((visibility glut:visibility-state))
    (if (eq visibility :visible)
        (glut:idle-func (cffi:callback idle))
        (glut:idle-func (cffi:null-pointer))))

  (glut:init)
  (glut:init-display-mode :double :rgb :depth)
  (glut:create-window "jc-opengl")
  (init-function)
  (glut:display-func (cffi:callback draw))
  (glut:reshape-func (cffi:callback reshape))
  (glut:keyboard-func (cffi:callback key))
  (glut:special-func (cffi:callback special))
  (glut:visibility-func (cffi:callback visible))
  (glut:main-loop))

(defun gl-sphere (x y z &key (radius 0.1) (color #(0.0 0.0 0.2 0.1)))
  (gl:light :light0 :position #(-100.0 -30.0 -100.0 0.0))
  (gl:push-matrix)
  (gl:translate x y z)
  (gl:enable :cull-face :lighting :light0 :depth-test)
  (gl:material :front :ambient-and-diffuse #(0.5 0.5 0.5 0))
  (gl:material :front :emission color)
  ;;(gl:material :front :shininess 0.1)
  (glut:solid-sphere radius 40 40)
  (gl:pop-matrix))

(defun gl-quit ()
  (glut:leave-main-loop))
