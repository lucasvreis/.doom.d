;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! scroll-restore)

;; Org
(package! org-appear)

;; julia mode
(package! julia-vterm)
(package! julia-repl :disable t)
(unpin! lsp-julia)
(unpin! julia-mode)

;; latex
;; (package! latex-preview-pane)
(package! aas :recipe (:host github :repo "ymarco/auto-activating-snippets"))
(package! laas :recipe (:host github :repo "tecosaur/LaTeX-auto-activating-snippets"))

;; doom
(package! ispell :disable t)
(package! hl-line :disable t)
(package! good-scroll)
(package! smooth-scrolling)
(package! scroll-on-drag)
(package! nyan-mode)

(package! mini-frame)

;; Tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)

(unpin! lsp-mode)
(package! lsp-treemacs)

(unpin! company-box)

(package! benchmark-init :recipe (:host github :repo "kekeimiku/benchmark-init-el"))
(unpin! consult)
(unpin! doom-themes)

(package! company-math)
(package! math-symbol-lists)
(package! company-math)
(package! real-auto-save)
(package! which-key-posframe)
(unpin! vertico)

(package! elcord)
