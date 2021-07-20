;;; lisp/minor/impatient.el -*- lexical-binding: t; -*-

(defun markdown-html (buffer)
  (princ
   (with-current-buffer buffer
     (format (cvs-file-to-string "~/.doom.d/lisp/minor/imp-markdown.html") (buffer-substring-no-properties (point-min) (point-max))))
   (current-buffer)))

(defun pandoc-org-to-html (buffer)
  (princ
    (shell-command-to-string
      (format "echo \"%s\" | pandoc -r org -w html --mathjax 2> /dev/null"
              (with-current-buffer buffer
                (buffer-substring-no-properties
                  (save-excursion
                    (goto-char 1)
                    (search-forward "\n---"))
                  (point-max)))))
    (current-buffer)))

(defun elisp-org-to-html (buffer)
  (let ((buf (current-buffer)))
    (with-current-buffer buffer
      (setq org-export-show-temporary-export-buffer nil)
      (org-export-to-buffer 'html buf))))
