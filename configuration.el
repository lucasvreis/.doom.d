(when (display-graphic-p)
  (setq good-scroll-duration 0.08)
  (good-scroll-mode 1))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package! selectrum
;;   :hook (doom-first-input . selectrum-mode))

;; (use-package! selectrum-prescient
;;   :after selectrum
;;   :config (selectrum-prescient-mode))

;; (use-package! marginalia
;;   :after selectrum
;;   :config
;;   (marginalia-mode)
;;   (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))

(use-package! embark
  :after ivy
  :bind (:map minibuffer-local-map
         ("C-o" . embark-act)
         :map embark-file-map
         ("j" . dired-jump)))

;; (setq projectile-completion-system 'default)

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

;; (aggressive-indent-global-mode +1)
