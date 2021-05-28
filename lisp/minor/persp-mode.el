;;; lisp/minor/persp-mode.el -*- lexical-binding: t; -*-

;; Disables the annoying, big and ugly messages when auto-saving
(defun inhibit-message-wrapper (f &rest r) (let ((inhibit-message t)) (apply f r)))

(advice-add 'persp-parameters-to-savelist :around #'inhibit-message-wrapper)

(remove-hook 'window-setup-hook #'doom-display-benchmark-h)
