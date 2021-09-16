;;; tangle/feature/mood-line.el -*- lexical-binding: t; -*-

(let* ((right (car (cdadar (cddadr (caaddr mode-line-format)))))
       (present (memq '(:eval (mlscroll-mode-line)) right)))
  (when (and right (not present))
    (push '(:eval (mlscroll-mode-line)) (car (cdadar (cddadr (caaddr mode-line-format)))))))
