(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br"

      doom-theme 'doom-challenger-deep

      doom-font (font-spec :family "JetBrains Mono" :size 17 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Noto Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :weight 'normal))

(setq all-the-icons-scale-factor 1)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique))

;; Hand-picked Unicode characters
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'unicode (font-spec :family "JetBrains Mono"))
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans mono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans") nil 'append)
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))

(load! "lisp/julia")
(load! "lisp/latex")
(load! "lisp/yasnippet")

(remove-hook! '(org-mode-hook text-mode-hook outline-mode-hook) #'flyspell-mode)

(pcre-mode +1)
(setq vterm-shell "fish")
(setq evil-cross-lines t)
(setq ispell-dictionary "brasileiro")
(setq delete-by-moving-to-trash t)
(setq lsp-idle-delay 0.01)
(setq company-idle-delay 0.01)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq scroll-step 1) ;; keyboard scroll one line at a time

(map! "C-S-s" 'isearch-forward)
(map! "C-s" 'save-buffer)

(map! :m "ç" 'god-execute-with-current-bindings)
(map! :i "C-ç" 'god-execute-with-current-bindings)

(map! "M-S-<right>" 'windsize-right)
(map! "M-S-<left>" 'windsize-left)
(map! "M-S-<down>" 'windsize-down)
(map! "M-S-<up>" 'windsize-up)

(map! "M-j" 'drag-stuff-down)
(map! "M-k" 'drag-stuff-up)

(map! :leader :desc "Toggle centaur tabs" "t t" 'centaur-tabs-local-mode)
(map! :gnvi "C-<tab>" 'centaur-tabs-forward
      :g "C-<iso-lefttab>" 'centaur-tabs-backward)

(map! :map 'lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)

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

(setq centaur-tabs-style "bar"
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
