;;; lisp/minor/yasnippet.el -*- lexical-binding: t; -*-

(add-hook 'snippet-mode-hook
          (lambda () (set (make-local-variable 'require-final-newline) nil)))


(setq yas-triggers-in-field t)

(defun yas-before-company (fun &rest r)
  (unless (yas-expand)
    (if (and yas--active-field-overlay
             (overlay-buffer yas--active-field-overlay))
        (yas-next-field)
      (apply fun r))))

;; (advice-add 'company-complete-common-or-cycle :around #'yas-before-company)
