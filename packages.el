;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! scroll-restore)

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
(package! windsize)
(package! good-scroll)
(package! smooth-scrolling)
(package! scroll-on-drag)
(package! nyan-mode)

(package! mini-frame)

;; Tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)
(package! less-theme :recipe (:host github :repo "nobiot/less-theme"))

(unpin! lsp-mode)
(package! lsp-treemacs)

(unpin! company-box)

;; (package! benchmark-init :recipe (:host github :repo "kekeimiku/benchmark-init-el"))
