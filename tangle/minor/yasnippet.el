;;; tangle/minor/yasnippet.el -*- lexical-binding: t; -*-
(defun yas--maybe-move-to-active-field (snippet)
  "Try to move to SNIPPET's active (or first) field and return it if found."
  (let ((target-field (or (yas--snippet-active-field snippet)
                          (car (yas--snippet-fields snippet)))))
    (when target-field
      (yas--move-to-field snippet target-field)
      (goto-char (yas--field-end target-field))
      target-field)))
