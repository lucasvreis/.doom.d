(setq +zen-text-scale 1)

(setq window-divider-default-bottom-width 2  ; default is 1
      window-divider-default-right-width 2)  ; default is 1

;; (nyan-mode t)

;; (defun company-yasnippet-or-completion ()
;;   (interactive)
;;   (let ((yas-fallback-behavior nil))
;;     (unless (yas-expand)
;;       (call-interactively #'company-complete-common))))

;; (after! company
;;   (add-hook 'company-mode-hook (lambda ())
;;             (substitute-key-definition 'company-complete-common
;;                                        'company-yasnippet-or-completion
;;                                        company-active-map)))

(setq centaur-tabs-style "wave"
      centaur-tabs-set-bar nil
      centaur-tabs-height 36
      centaur-tabs-plain-icons t
      centaur-tabs-label-fixed-length 10)

(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))

(setq +treemacs-git-mode 'deferred
      treemacs-width 26
      doom-themes-treemacs-theme "doom-colors"
      doom-themes-treemacs-bitmap-indicator-width 1
      doom-themes-treemacs-enable-variable-pitch nil)

(aggressive-indent-global-mode +1)
