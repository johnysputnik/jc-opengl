


;;; test

;; (require 'bordeaux-threads)

(in-package :jc-opengl)

;; simple conversion functions

(defun degrees-to-radians (d)
  (* d 0.0174533))

;; position calculation

(defun calculate-x-position (center-x angle radius)
  (let ((a (degrees-to-radians angle)))
    (+ center-x (* radius (cos a)))))

(defun calculate-y-position (center-y angle radius)
  (let ((a (degrees-to-radians angle)))
    (+ center-y (* radius (sin a)))))

;; a starting angle

(defparameter angle 0)
(defparameter angle-increment 5)


;; macros for defining planets in a DSL stylee

;; (defmacro star (planet &key radius position color)
;;   `(lambda () (gl-sphere ,@position
;;                          :radius ,radius
;;                          :color ,color)))


;; A simple planetary system definition

;; (defplanets my-planets (star :radius 0.2
;;                              :position (1 0 0)
;;                              :color #(0.4 0.4 0.0 1)
;;                              (planet :radius 0.07
;;                                      :distance 3
;;                                      :color #(0.0 0.0 0.6 1)
;;                                      :angular-velocity 0.01
;;                                      (moon :radius 0.0175
;;                                            :distance 0.5
;;                                            :angular-velocity 3
;;                                            :color #(0.9 0.1 0.9 1)))




;; opengl functions

(definit t)

(defdraw
    (setq angle (+ angle angle-increment))
    (let ((planet-x-pos (calculate-x-position 1 (/ angle 36) 3))
          (planet-y-pos (calculate-y-position 0 (/ angle 36) 3)))
      (gl-sphere 1 0 0
                 :radius 0.2
                 :color #(0.9 0.9 0.2 1))
      (gl-sphere planet-x-pos 0 planet-y-pos
                 :radius 0.05
                 :color #(0.0 0.0 0.1 1))
      (gl-sphere (calculate-x-position 1 (/ angle 22) 1) 0 (calculate-y-position 0 (/ angle 22) 1)
                 :radius 0.04
                 :color #(0.5 0.0 0.1 1))
      (gl-sphere (calculate-x-position planet-x-pos angle 0.2) 0 (calculate-y-position planet-y-pos angle 0.2)
                 :radius 0.01
                 :color #(0.1 0.1 0.1 1))))

(defreshape t)


(defkey
    (case (code-char key)
      (#\Esc (gl-quit))))

(defspecial t)


;; run the system

(defun run ()
  (gl-run))


;;(defparameter *my-thread* (bt:make-thread
;;                           (lambda ()
;;                             (run))))
