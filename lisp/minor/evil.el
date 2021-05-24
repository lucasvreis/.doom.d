;;; lisp/minor/evil.el -*- lexical-binding: t; -*-

(setq evil-shift-round nil
      evil-cross-lines t)

(defun evil-shift-width-elisp-advice (fun &rest r)
  (if (eq major-mode 'emacs-lisp-mode)
      (setq evil-shift-width 2)
    (apply fun r)))

(advice-add 'doom--setq-evil-shift-width-for-after-change-major-mode-h
            :around #'evil-shift-width-elisp-advice)
