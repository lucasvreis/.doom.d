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
;; (package! frame-workflow :recipe (:host github :repo "akirak/frame-workflow"))
;; (package! undo-tree :recipe (:host gitlab :repo "tsc25/undo-tree"))
(package! smooth-scrolling)
(package! mixed-pitch)
(package! nyan-mode)
(package! lsp-treemacs)
(package! org-journal)


(package! embark)

;; Tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)


(unpin! company-box)
(unpin! lsp-mode)

(package! less-theme :recipe (:host github :repo "nobiot/less-theme"))
(package! smudge)
