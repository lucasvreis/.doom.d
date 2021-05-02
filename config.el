;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; -*- eval: (flycheck-mode -1); -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br"

      doom-theme 'doom-challenger-deep

      doom-font (font-spec :family "JetBrains Mono" :size 17 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Noto Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :weight 'normal))

(setq all-the-icons-scale-factor 0.8)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique))

;; Hand-picked Unicode characters
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'unicode (font-spec :family "JetBrains Mono"))
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans mono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans") nil 'append)
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(load! "lisp/julia")
(load! "lisp/latex")
(load! "lisp/yasnippet")

(require 'org)
(org-babel-load-file "~/.doom.d/bindings.org")
(org-babel-load-file "~/.doom.d/configuration.org")

(remove-hook! '(org-mode-hook text-mode-hook outline-mode-hook) #'flyspell-mode)

(pcre-mode +1)
(setq vterm-shell "fish")
(setq evil-cross-lines t)
(setq ispell-dictionary "brasileiro")
(setq yas-triggers-in-field t)
(setq delete-by-moving-to-trash t)
(setq lsp-idle-delay 0.01)
(setq company-idle-delay 0.01)

;; Treemacs

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq scroll-step 1) ;; keyboard scroll one line at a time
