;;; nanomacs.el --- Library to work with my nanoc personal website  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Lucas Reis

;; Author: Lucas Reis <lucas@lucas>
;; Keywords: lisp, nanoc


(defun nanoc-insert-identifier ()
  (interactive)
  (dotimes (_ 10)
    (insert
     (let ((x (random 36)))
       (if (< x 10) (+ x ?0) (+ x (- ?a 10)))))))
