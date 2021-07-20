;;; lisp/lib/org-frontmatter.el -*- lexical-binding: t; -*-

(defface org-frontmatter-face
  '((t (:inherit shadow :slant italic)))
  "Face for frontmatter delimiters."
  :group 'org-frontmatter-faces)

(defun org-fontify-frontmatter (buffer)
  (with-current-buffer buffer
    (if (and (eq (char-after 1) ?-) (eq (char-after 2) ?-) (eq (char-after 3) ?-))
      (save-excursion
        (goto-char 1)
        (search-forward "\n---")
        (add-text-properties 1 (point) '(font-lock-face org-frontmatter-face))))))
