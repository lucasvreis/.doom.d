;;; -*- lexical-binding: t; -*-

(setq doom-theme 'doom-flatwhite)

;; Deixa a seleção menos distrativa
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
    doom-ephemeral
    doom-nova
    doom-opera
    doom-zenburn
    doom-ayu-mirage
    doom-vibrant
    doom-ir-black
    doom-old-hope
    doom-miramare
    doom-monokai-spectrum
    doom-monokai-ristretto))

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
  '(doom-modeline-info :foreground "white")
  `(org-latex-and-related :background ,(cadr (assq 'cyan doom-themes--colors)) :weight normal))

(custom-theme-set-faces! 'doom-flatwhite
  `(org-latex-and-related :background ,(cadr (assq 'fw-green-blend doom-themes--colors)) :weight normal))

(setq all-the-icons-scale-factor 0.88)

(setq window-divider-default-bottom-width 2   ; default is 1
      window-divider-default-right-width  2)  ; default is 1

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

(let ((default-directory "~/.doom.d/lisp/lib"))
  (normal-top-level-add-subdirs-to-load-path))
(add-load-path! "lisp/lib")

(defun string-list-p (x) (and (listp x) (--all? (stringp it) x)))

(defun advice-unadvice (sym)
  "Remove all advices from symbol SYM."
  (interactive "aFunction symbol: ")
  (advice-mapc (lambda (advice _props) (advice-remove sym advice)) sym))

(defun advice--inhibit-message (f &rest r) (let ((inhibit-message t)) (apply f r)))

(defun custom-tex--prettify-symbols-compose-p (_start end _match)
  (or
   ;; If the matched symbol doesn't end in a word character, then we
   ;; simply allow composition.  The symbol is probably something like
   ;; \|, \(, etc.
   (not (eq ?w (char-syntax (char-before end))))
   ;; Else we look at what follows the match in order to decide.
   (let* ((after-char (char-after end))
          (after-syntax (char-syntax after-char)))
     (not (or
           ;; Don't compose \alpha@foo.
           (eq after-char ?@)
           ;; The \alpha in \alpha2 or \alpha-\beta may be composed but
           ;; of course \alphax may not.
           (and (eq after-syntax ?w)
                (not (memq after-char
                           '(?0 ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?+ ?- ?' ?\" ?$ ?_))))
           ;; Don't compose inside verbatim blocks.
           (eq 2 (nth 7 (syntax-ppss))))))))

(defun define-prettify-symbols ()
  (require 'prettify-utils)
  (require 'tex-mode)
  (load! "script/prettify-latex-autogen" doom-private-dir)
  (setq tex--prettify-symbols-alist
        (append
          '(("\\left" . ?ₗ)
            ("\\right" . ?ᵣ)
            ("_n" . ?ₙ)
            ("_k" . ?ₖ)
            ("\\tilde" . ?˜)
            ("\\dots" . ?…))
          (prettify-utils-generate
            ("^{-1}" "⁻¹")
            ("_{i=1}" "ᵢ₌₁")
            ("\\not\\subset" "⊄"))
          prettify-mode--latex-autogen-alist
          (bound-and-true-p tex--prettify-symbols-alist))))

(defun setup-latex-prettify ()
  (set (make-local-variable 'prettify-symbols-alist) tex--prettify-symbols-alist)
  (add-function :override (local 'prettify-symbols-compose-predicate)
                #'custom-tex--prettify-symbols-compose-p))

(when (display-graphic-p)
  (setq good-scroll-duration 0.08)
  (good-scroll-mode 1))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
      scroll-step 1) ;; keyboard scroll one line at a time

(setq-default fill-column 80)

(setq mouse-drag-and-drop-region t
      mouse-drag-and-drop-region-cut-when-buffers-differ t
      mouse-drag-and-drop-region-show-tooltip nil)

;; FIXME
(advice-add 'save-buffer :around #'advice--inhibit-message)

(blink-cursor-mode +1)

(add-hook! 'text-mode-hook
           (abbrev-mode +1))

(pcre-mode +1)

(require 'context-menu)
(map! [mouse-3] 'my-context-menu)

(remove-hook! '(org-mode-hook text-mode-hook) #'flyspell-mode)

(setq vterm-shell "zsh"
      ispell-dictionary "brasileiro"
      delete-by-moving-to-trash t
      mouse-autoselect-window nil)

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

(map! "C-S-s" 'isearch-forward)
(map! :egni "C-s" 'save-buffer)
(map! :egni "C-/" 'evilnc-comment-or-uncomment-lines)

(map! :i "C-v" 'yank)
(map! :i "C-z" 'evil-undo)
(map! :i "C-S-z" 'evil-redo)
(map! :i "C-x" 'evil-delete)

;; no dia em que eu precisar usar teclado americano, eu vou me arrepender...
(map! :map evil-motion-state-map
      "j" 'evil-backward-char
      "k" 'evil-next-line
      "l" 'evil-previous-line
      "ç" 'evil-forward-char)

(map! :map evil-window-map
      ;; Navigation
      "j"       #'evil-window-left
      "k"       #'evil-window-down
      "l"       #'evil-window-up
      "ç"       #'evil-window-right
      "C-j"     #'evil-window-left
      "C-k"     #'evil-window-down
      "C-l"     #'evil-window-up
      "C-ç"     #'evil-window-right
      ;; Swapping windows
      "J"       #'+evil/window-move-left
      "K"       #'+evil/window-move-down
      "L"       #'+evil/window-move-up
      "Ç"       #'+evil/window-move-right)

(map! :i "M-J" 'evil-backward-char
      :i "M-K" 'evil-next-line
      :i "M-L" 'evil-previous-line
      :i "M-Ç" 'evil-forward-char)

(after! treemacs (evil-define-key 'treemacs treemacs-mode-map "l" nil "h" nil))

;; (evil-define-key '(visual normal) Info-mode-map "l" nil)
(map! :map Info-mode-map :vn "l" nil)

(map! :after treemacs
      :map evil-treemacs-state-map
      "j"      #'treemacs-COLLAPSE-action
      "k"      #'treemacs-next-line
      "l"      #'treemacs-previous-line
      "ç"      #'treemacs-RET-action)

(defhydra window-height-hydra (evil-window-map)
  "window height"
  ("=" evil-window-increase-height "increase")
  ("-" evil-window-decrease-height "decrease"))

(map! :prefix-map ("\x80" . "kitty C map")
      :map 'key-translation-map
      "/" "C-/")

(map! :prefix-map ("\x81" . "kitty C-S map")
      :map 'key-translation-map
      "z" (kbd "C-S-z"))

(map! :leader
      :prefix ("e" . "edit")
      :desc "New snipet" "s" #'+snippets/new
      :desc "New alias" "a" #'+snippets/new-alias)

(map! "M-S-<right>" 'windsize-right
      "M-S-<left>" 'windsize-left
      "M-S-<down>" 'windsize-down
      "M-S-<up>" 'windsize-up)

(map! "M-j" 'drag-stuff-down
      "M-k" 'drag-stuff-up)

(map! :leader :desc "Centered mode" "t e" 'olivetti-mode)

(map! :map lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)

(load! "lisp/use-packages")

(load! "lisp/defcustoms.el")

(dolist (type '(major minor))
  (let ((folder (format "~/.doom.d/lisp/%s/" type)))
    (dolist (file (file-expand-wildcards (concat folder "*.el")))
      (let ((f (file-name-sans-extension (file-name-nondirectory file))))
        (eval `(after! ,(intern f) (load! ,f ,folder)))))))

(after! projectile
    (projectile-register-project-type 'julia '("Project.toml")
                                    :project-file "Project.toml"
                                    :test "julia -e \"using Pkg; Pkg.test()\""))
