 ;;; -*- lexical-binding: t; -*-

(defun xenops-mode--should-enable-p ()
  (not (bound-and-true-p polymode-mode)))

(use-package! xenops
  :if (xenops-mode--should-enable-p)
  :config
  (setq xenops-math-image-scale-factor 1.2)
        ;; xenops-font-family "NewComputerModern Sans"
        ;; xenops-reveal-on-entry nil
  (add-hook! xenops-mode
    (xenops-xen-mode +1)
    (solaire-mode -1)))
