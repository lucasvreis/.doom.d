;; -*- lexical-binding: t -*-

(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br"

      doom-theme 'doom-dracula
      doom-dracula-brighter-modeline t

      doom-font (font-spec :family "VictorMono Nerd Font Mono" :size 19 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Crimson" :size 26)
      doom-unicode-font (font-spec :family "JuliaMono" :weight 'normal))


;; Hand-picked Unicode characters
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'unicode (font-spec :family "JuliaMono"))
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans mono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans") nil 'append)
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))

(add-load-path! "lisp/lib")

(load! "lisp/bindings")
(load! "lisp/use-packages")
(load! "lisp/doom-customizations")

;; "Let's make this work, at any cost"
(dolist (type '(major minor))
  (let ((folder (format "~/.doom.d/lisp/%s/" type)))
    (dolist (file (file-expand-wildcards (concat folder "*.el")))
      (let ((f (file-name-sans-extension (file-name-nondirectory file))))
        (eval `(after! ,(intern f) (load! ,f ,folder)))))))

(remove-hook! '(org-mode-hook text-mode-hook) #'flyspell-mode)

(when (display-graphic-p)
  (setq good-scroll-duration 0.08)
  (good-scroll-mode 1))

(setq window-divider-default-bottom-width 2  ; default is 1
      window-divider-default-right-width 2  ; default is 1

      vterm-shell "fish"
      ispell-dictionary "brasileiro"
      delete-by-moving-to-trash t
      mouse-autoselect-window nil
      lsp-idle-delay 0.1
      company-idle-delay 0.1

      mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
      scroll-step 1) ;; keyboard scroll one line at a time

(pcre-mode +1)

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
