(setq user-full-name "Lucas Viana Reis"
      user-mail-address "l240191@dac.unicamp.br"

      doom-theme 'doom-challenger-deep

      doom-font (font-spec :family "VictorMono Nerd Font Mono" :size 20 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Crimson" :size 26)
      doom-unicode-font (font-spec :family "JuliaMono" :weight 'normal))

(setq all-the-icons-scale-factor 0.88)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique))

;; Hand-picked Unicode characters
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'unicode (font-spec :family "JuliaMono"))
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans mono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "DejaVu sans") nil 'append)
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))

(add-load-path! "lisp/lib")
(load! "lisp/use-packages")

(after! org        (load! "lisp/major/org"))
(after! julia-mode (load! "lisp/major/julia"))
(after! latex      (load! "lisp/major/latex"))
(after! treemacs   (load! "lisp/major/treemacs"))
(after! pdf-tools  (load! "lisp/major/pdf-tools"))

(after! centaur    (load! "lisp/minor/centaur"))
(after! ivy        (load! "lisp/minor/completion"))
(after! evil       (load! "lisp/minor/evil"))
(after! impatient  (load! "lisp/minor/impatient"))
(after! polymode   (load! "lisp/minor/polymode"))
(after! yasnippet  (load! "lisp/minor/yasnippet"))
(after! smudge     (load! "lisp/minor/smudge"))
(load! "lisp/minor/solaire")

(after! parinfer-rust-mode
  (setq parinfer-rust-preferred-mode "indent"))

(remove-hook! '(org-mode-hook text-mode-hook) #'flyspell-mode)


(when (display-graphic-p)
  (setq good-scroll-duration 0.08)
  (good-scroll-mode 1))

(setq window-divider-default-bottom-width 2  ; default is 1
      window-divider-default-right-width 2)  ; default is 1

(setq vterm-shell "fish")
(setq ispell-dictionary "brasileiro")
(setq delete-by-moving-to-trash t)
(setq lsp-idle-delay 0.01)
(setq company-idle-delay 0.01)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
      scroll-step 1 ;; keyboard scroll one line at a time
      scroll-margin 3)

(setq-hook! 'prog-mode-hook
  header-line-format " ")

(pcre-mode +1)

(defun yas-before-company (fun &rest r)
  (unless (yas-expand)
    (if (and yas--active-field-overlay
             (overlay-buffer yas--active-field-overlay))
        (yas-next-field)
      (apply fun r))))

(advice-add 'company-complete-common-or-cycle :around #'yas-before-company)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner
          '("   o__  __o   \\o__ __o__ __o      o__ __o/      __o__      __o__"
            "  /v      |>   |     |     |>    /v     |      />  \\      />  \\ "
            " />      //   / \\   / \\   / \\   />     / \\   o/           \\o    "
            " \\o    o/     \\o/   \\o/   \\o/   \\      \\o/  <|             v\\   "
            "  v\\  /v __o   |     |     |     o      |    \\\\             <\\  "
            "   <\\/> __/>  / \\   / \\   / \\    <\\__  / \\    _\\o__</  _\\o__</  "))
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
