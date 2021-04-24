(setq +zen-text-scale 1)

(setq window-divider-default-bottom-width 4  ; default is 1
      window-divider-default-right-width 4)  ; default is 1

(nyan-mode t)

(defun company-yasnippet-or-completion ()
  (interactive)
  (let ((yas-fallback-behavior nil))
    (unless (yas-expand)
      (call-interactively #'company-complete-common))))

(add-hook 'company-mode-hook (lambda ())
  (substitute-key-definition 'company-complete-common
                             'company-yasnippet-or-completion
                             company-active-map))
