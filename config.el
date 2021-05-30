;;; -*- lexical-binding: t; -*-

(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br")

(setq doom-theme 'doom-ayu-light)

;; Make theme selection less distracting
(defvar custom-themes-exclude
  '(doom-acario-light
    doom-acario-dark
    doom-badger
    doom-dark+
    doom-henna
    doom-homage-white
    doom-Iosvkem
    doom-1337
    doom-molokai
    doom-sourcerer
    doom-peacock
    doom-wilmersdorf
    doom-manegarm
    doom-ephemeral))


(advice-add 'custom-available-themes :filter-return
            (lambda (l)
              (seq-difference
               (seq-filter (lambda (x) (s-prefix? "doom-" (symbol-name x))) l)
               custom-themes-exclude #'eq)))

(setq doom-font                (font-spec :family "JetBrains Mono" :size 19)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 19)
      doom-serif-font          (font-spec :family "IBM Plex Mono" :weight 'light)
      doom-unicode-font        (font-spec :family "JuliaMono" :weight 'normal))

;; Colocamos uma ordem de prioridade para tentar ter todos os unicodes e emojis.
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'unicode (font-spec :family "JuliaMono"))
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique)

  '(yas-field-highlight-face :box (:color "dark green") :inherit nil)

  '(doom-modeline-buffer-modified :foreground "orange")
  '(doom-modeline-info :foreground "white"))

(setq all-the-icons-scale-factor 0.88)

;; Desabilita o modeline
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1))

;; Desabilita o "benchmark"
(remove-hook 'window-setup-hook #'doom-display-benchmark-h)

(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner
          '("" ""
            "   o__  __o   \\o__ __o__ __o      o__ __o/      __o__      __o__"
            "  /v      |>   |     |     |>    /v     |      />  \\      />  \\ "
            " />      //   / \\   / \\   / \\   />     / \\   o/           \\o    "
            " \\o    o/     \\o/   \\o/   \\o/   \\      \\o/  <|             v\\   "
            "  v\\  /v __o   |     |     |     o      |    \\\\             <\\  "
            "   <\\/> __/>  / \\   / \\   / \\    <\\__  / \\    _\\o__</  _\\o__</  "
            ""))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))
(setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn)

(custom-set-faces!
  '(doom-dashboard-banner
    :inherit font-lock-comment-face
    :slant normal))

(add-load-path! "lisp/lib")

(defun advice-unadvice (sym)
  "Remove all advices from symbol SYM."
  (interactive "aFunction symbol: ")
  (advice-mapc (lambda (advice _props) (advice-remove sym advice)) sym))

(defun advice--inhibit-message (f &rest r) (let ((inhibit-message t)) (apply f r)))

(setq-default fill-column 100)

;; FIXME
(advice-add 'save-buffer :around #'advice--inhibit-message)

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

(load! "lisp/bindings")
(load! "lisp/use-packages")

;; "Let's make this work, at any cost"
(dolist (type '(major minor))
  (let ((folder (format "~/.doom.d/lisp/%s/" type)))
    (dolist (file (file-expand-wildcards (concat folder "*.el")))
      (let ((f (file-name-sans-extension (file-name-nondirectory file))))
        (eval `(after! ,(intern f) (load! ,f ,folder)))))))
