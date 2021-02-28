;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-material)
(setq doom-font (font-spec :family "Fira Code" :size 20))
(set-fontset-font "fontset-default" 'unicode "Twemoji" nil 'prepend)
(set-fontset-font "fontset-default" nil (font-spec :name "DejaVu Sans"))

;; Unicode characters

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

;; Fira Code
(when (display-graphic-p)
  (use-package fira-code-mode
    :custom (fira-code-mode-disabled-ligatures '("[]" "x" "*" ":" "+"))  ; ligatures you don't want
    :hook prog-mode))



(add-hook 'change-major-mode-hook (lambda () (pixel-scroll-mode -1)))

(general-define-key :keymaps 'lean-mode-map (kbd "M-.") 'lean-find-definition)
(general-define-key :states 'normal :keymaps 'override (kbd "C-<tab>") 'ivy-switch-buffer)


;; Maximize window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq vterm-shell "fish")
(setq evil-cross-lines t)
(menu-bar-mode t)
(good-scroll-mode t)

(general-define-key :states 'normal :keymaps 'override (kbd "C-S-<left>") 'windsize-left)
(general-define-key :states 'normal :keymaps 'override (kbd "C-S-<right>") 'windsize-right)
(general-define-key :states 'normal :keymaps 'override (kbd "C-S-<up>") 'windsize-up)
(general-define-key :states 'normal :keymaps 'override (kbd "C-S-<down>") 'windsize-down)
