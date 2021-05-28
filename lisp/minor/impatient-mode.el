;;; lisp/minor/impatient.el -*- lexical-binding: t; -*-

(defun markdown-html (buffer)
  (princ
   (with-current-buffer buffer
     (format (cvs-file-to-string "~/.doom.d/lisp/minor/imp-markdown.html") (buffer-substring-no-properties (point-min) (point-max))))
   (current-buffer)))
