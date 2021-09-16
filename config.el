;;; -*- lexical-binding: t; -*-

(setq doom-theme 'doom-moonlight)

(defvar my/custom-themes-exclude
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
               my/custom-themes-exclude #'eq)))

(setq doom-font                (font-spec :family "VictorMono Nerd Font Mono" :size 20 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 19 :weight 'light)
      doom-serif-font          (font-spec :family "IBM Plex Mono" :weight 'light))
      ;; doom-unicode-font        (font-spec :family "JuliaMono" :weight 'normal))

;; Colocamos uma ordem de prioridade para tentar ter todos os unicodes e emojis.
(setq use-default-font-for-symbols t)
(defun my/adjust-fonts ()
  (set-fontset-font t 'unicode (font-spec :family "JuliaMono" :weight 'light))
  (set-fontset-font t 'unicode "Twemoji" nil 'append))

(add-hook! 'after-setting-font-hook #'my/adjust-fonts)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique))

(custom-set-faces!
  `(yas-field-highlight-face
    :inherit nil
    :background ,(doom-blend "#b315b3" (doom-color 'bg) 0.4)
    :foreground "undefined"))

(custom-set-faces!
  `(org-latex-and-related :weight normal)
  `(font-latex-math-face :inherit org-latex-and-related :foreground ,(doom-color 'fg))
  '(org-block-begin-line :extend t))
(custom-theme-set-faces! 'doom-flatwhite
  `(org-latex-and-related :foreground nil :background ,(doom-color 'fw-green-blend)))
(custom-set-faces!
  '(outline-1 :weight extra-bold)
  '(outline-2 :weight bold)
  '(outline-3 :weight bold)
  '(outline-4 :weight semi-bold)
  '(outline-5 :weight semi-bold)
  '(outline-6 :weight semi-bold)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  `(org-hide :foreground ,(doom-color 'bg)))

(setq all-the-icons-scale-factor 0.88)

(custom-theme-set-faces! 'doom-rouge
  '(hl-line :background "#171727"))

(custom-set-faces!
  '(mode-line :height 110 :family "JuliaMono")
  '(mode-line-inactive :height 110 :family "JuliaMono")
  '(doom-modeline-buffer-modified :foreground "#c63")
  '(doom-modeline-info :foreground "white"))
(setq! +modeline-height 26)

(setq doom-modeline-irc nil
      doom-modeline-icon nil)

(setq window-divider-default-bottom-width 2   ; default is 1
      window-divider-default-right-width  2)  ; default is 1

;; Desabilita o "benchmark"
(remove-hook 'window-setup-hook #'doom-display-benchmark-h)

(setq +doom-dashboard-functions '(doom-dashboard-widget-shortmenu
                                  doom-dashboard-widget-loaded))

(custom-set-faces!
  '(doom-dashboard-banner
    :inherit font-lock-comment-face
    :slant normal))

(defvar my/zen-enabled nil)

(defun my/zen-enable ()
  (interactive)
  (require 'org-starless)
  (hide-mode-line-mode +1)
  (org-starless-mode +1)
  (org-indent-mode -1)
  (setq-local my/zen-enabled t
              line-spacing 0.1
              display-line-numbers nil))

(defun my/zen-disable ()
  (interactive)
  (hide-mode-line-mode -1)
  (org-starless-mode +1)
  (org-indent-mode +1)
  (setq-local my/zen-enabled nil
              line-spacing 0
              display-line-numbers t))

(defun my/zen-toggle ()
  (interactive)
  (if my/zen-enabled
      (my/zen-disable)
    (my/zen-enable)))

(map! :leader "t z" #'my/zen-toggle)

(let ((default-directory "~/.doom.d/lisp/lib"))
  (normal-top-level-add-subdirs-to-load-path))
(add-load-path! "lisp/lib")

(defun advice--inhibit-message (f &rest r) (let ((inhibit-message t)) (apply f r)))

(defun string-list-p (x) (and (listp x) (--all? (stringp it) x)))

(defun advice-unadvice (sym)
  "Remove all advices from symbol SYM."
  (interactive "aFunction symbol: ")
  (advice-mapc (lambda (advice _props) (advice-remove sym advice)) sym))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
      scroll-margin 4
      scroll-step 1) ;; keyboard scroll one line at a time

(setq-default fill-column 80)

(setq amalgamating-undo-limit 1)

(setq gcmh-idle-delay 5)

(setq company-idle-delay 0.01
      company-minimum-prefix-length 4)

(setq mouse-drag-and-drop-region t
      mouse-drag-and-drop-region-cut-when-buffers-differ t
      mouse-drag-and-drop-region-show-tooltip nil)

(setq default-input-method "TeX")

(setq text-scale-mode-step 1.05)

(advice-add 'save-buffer :around #'advice--inhibit-message)

(add-hook! 'text-mode-hook
           (abbrev-mode +1))

(setq abbrev-file-name (concat doom-private-dir "abbrev_defs"))

(pcre-mode +1)

(require 'context-menu)
(map! [mouse-3] 'my-context-menu)

(setq +popup-defauts
      '(:side bottom
        :height 0.3
        :width 130
        :quit t
        :select ignore
        :ttl 5))

(setq +popup-default-alist
      '((window-height . 0.3)
        (reusable-frames . visible)))

(remove-hook! '(org-mode-hook text-mode-hook) #'flyspell-mode)

(setq vterm-shell "zsh"
      delete-by-moving-to-trash t
      mouse-autoselect-window nil)

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package prettify-utils
  :after (org latex))

(use-package tree-sitter
  :after doom-first-file-hook
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package scroll-on-drag
  :bind ([down-mouse-2] . #'scroll-on-drag))

(defun yas-get-snippet (mode key)
       (yas--fetch (yas--get-snippet-tables mode) key))

(use-package laas
  :commands (laas-mode))

(use-package lean4-mode
  :commands (lean4-mode))

(use-package mamimo
  :hook ((org-mode latex-mode markdown-mode) . mamimo-mode))

(setq org-directory "~/Lucas/org"
      org-attach-id-dir "data/"
      org-startup-folded t
      org-latex-packages-alist '(("" "tikz" t) ("" "tikz-cd" t))
      org-support-shift-select t
      org-hide-emphasis-markers nil
      org-latex-pdf-process '("%latex %f")
      org-latex-compilers '("tectonic" "pdflatex" "xelatex" "lualatex")
      org-latex-compiler "tectonic"
      org-src-window-setup 'plain
      org-highlight-latex-and-related '(native script)
      org-emphasis-regexp-components '("-[:space:]('\"{" "-[:space:].,:!?;'\")}\\[" "{}*[:space:]" "." 1)
      org-indent-indentation-per-level 1)

(push 'org-mode git-gutter:disabled-modes)

(setq lsp-haskell-server-path "~/.local/bin/haskell-language-server-wrapper")

(setq ispell-dictionary "pt_BR,en_US"
      ispell-personal-dictionary (concat doom-private-dir ".hunspell-personal"))

(unless (file-exists-p ispell-personal-dictionary)
  (write-region "" nil ispell-personal-dictionary nil 0))

(after! ispell
  (ispell-hunspell-add-multi-dic "pt_BR,en_US")
  (ispell-set-spellchecker-params))

(setq orderless-matching-styles
      '(orderless-initialism
        orderless-literal
        orderless-regexp))

(setq org-roam-directory "~/Lucas/notas"
      +org-roam-open-buffer-on-find-file nil)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t))

(after! projectile
    (projectile-register-project-type 'julia '("Project.toml")
                                    :project-file "Project.toml"
                                    :test "julia -e \"using Pkg; Pkg.test()\""))

(defcustom treemacs-file-ignore-extensions
  '("aux" "ptc" "fdb_latexmk" "fls" "synctex.gz" "toc"         ;; LaTeX
    "glg"  "glo"  "gls"  "glsdefs"  "ist"  "acn"  "acr"  "alg" ;; LaTeX - glossary
    "mw"                                                       ;; LaTeX - pgfplots
    "pdfa.xmpi")                                               ;; LaTeX - pdfx
  "File extension which `treemacs-ignore-filter' will ensure are ignored"
  :safe #'string-list-p)

(defcustom treemacs-file-ignore-globs
  '("*/_minted-*"                                        ;; LaTeX
     "*/.auctex-auto" "*/_region_.log" "*/_region_.tex") ;; AucTeX
  "Globs which will are transformed to `treemacs-file-ignore-regexps'
which `treemacs-ignore-filter' will ensure are ignored"
  :safe #'string-list-p)

(setq doom-themes-treemacs-bitmap-indicator-width 8)

(setq elcord-editor-icon "emacs_icon"
      elcord-display-elapsed nil
      elcord--editor-name "Emacs"
      elcord-use-major-mode-as-main-icon t)

(setq evil-shift-round nil
      evil-cross-lines t

      ;; Respeita linhas visuais
      evil-respect-visual-line-mode t

      ;; Substitui vários matches por linha no evil-ex
      evil-ex-substitute-global t)

(setq flyspell-lazy-idle-seconds 0.4)

(map! :ni "C-." #'flyspell-correct-move)

(setq focus-fraction 0.7)
(custom-set-faces!
  '(focus-unfocused :inherit custom-comment-tag :foreground "gray"))

(setq iedit-toggle-key-default nil)

(setq parinfer-rust-preferred-mode "indent")

(setq mamimo-greek-abbrevs-prefix ";")
(add-hook! 'mamimo-mode-hook
  (evil-tex-mode +1))

(defface my-mixed-pitch-face
  '((t :family "Overpass" :weight light))
  "Face for `mixed-pitch-mode'")
(setq mixed-pitch-face 'my-mixed-pitch-face
      mixed-pitch-set-height nil)

(dolist (type '(major minor features))
  (let ((folder (format "~/.doom.d/lisp/%s/" type)))
    (dolist (file (file-expand-wildcards (concat folder "*.el")))
      (let ((f (file-name-sans-extension (file-name-nondirectory file))))
        (eval `(after! ,(intern f) (load! ,f ,folder)))))))

(dolist (type '(major minor features))
  (let ((folder (format "%stangle/%s/" doom-private-dir type)))
    (dolist (file (file-expand-wildcards (concat folder "*.el")))
      (let ((f (file-name-sans-extension (file-name-nondirectory file))))
        (eval `(after! ,(intern f) (load! ,f ,folder)))))))

(map! :mode 'org-mode
      :map 'doom-leader-search-map
      "I" (cmd! (funcall-interactively (key-binding " si"))
                (org-tree-to-indirect-buffer)))

;; (map! "C-S-s" 'isearch-forward)
(map! :egni "C-s" 'save-buffer)
(map! :egni "C-/" 'evilnc-comment-or-uncomment-lines)

(map! :i "C-v" 'yank)
(map! :i "C-z" 'evil-undo)
(map! :i "C-S-z" 'evil-redo)
(map! :i "C-x" 'evil-delete)

(map! :map evil-motion-state-map
      "j" 'evil-next-visual-line
      "k" 'evil-previous-visual-line
      "<down>" 'evil-next-visual-line
      "<up>" 'evil-previous-visual-line)

(setq hydra-is-helpful nil)

(defhydra window-height-hydra (evil-window-map)
  "window height"
  ("=" evil-window-increase-height "")
  ("-" evil-window-decrease-height "")
  (">" evil-window-increase-width "")
  ("<" evil-window-decrease-width ""))

(defhydra workspace-hydra (doom-leader-workspace-map)
  "workspace"
  ("]" +workspace/switch-right "")
  ("[" +workspace/switch-left "")
  ("}" +workspace/swap-right "")
  ("{" +workspace/swap-left ""))

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

(map! :i "C-M-x" ctl-x-map)

;; (evil-define-motion search-previous-and-recenter (count)
;;   :jump t
;;   :type exclusive
;;   (evil-ex-search-previous count)
;;   (call-interactively #'evil-scroll-line-to-center))

;; (map! :n [remap evil-ex-search-previous] #'search-previous-and-recenter)

(map! "M-j" 'drag-stuff-down
      "M-k" 'drag-stuff-up)

(map! :map lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)
