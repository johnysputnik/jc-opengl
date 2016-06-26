(in-package #:jc-opengl)

;;; macros for creating the main gl callbacks

(defmacro definit (&rest body)
  `(defun init-function () (progn ,@body)))

(defmacro defdraw (&rest body)
  `(defun draw-function () (progn ,@body)))

(defmacro defreshape (&rest body)
  `(defun reshape-function () (progn ,@body)))

(defmacro defkey (&rest body)
  `(defun key-function (key) (progn ,@body)))

(defmacro defspecial (&rest body)
  `(defun special-function (key) (progn ,@body)))

