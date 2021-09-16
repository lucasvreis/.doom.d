;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; latex
;; (package! latex-preview-pane)
(package! aas :recipe (:host github :repo "ymarco/auto-activating-snippets"))

;; doom
(package! writegood-mode :disable t)
(package! hl-line :disable t)
(package! smooth-scrolling)
(package! scroll-on-drag)
(package! nyan-mode)

;; Tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)

(package! lsp-treemacs)

(unpin! lsp-mode)
;; (unpin! consult)
(unpin! doom-themes)
(unpin! vertico)
(unpin! treemacs)

(package! benchmark-init :recipe (:host github :repo "kekeimiku/benchmark-init-el"))

(unpin! evil-tex)
(unpin! company-math)
(package! company-math)
(package! math-symbol-lists)
(package! company-math)
(package! real-auto-save)

(package! websocket)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))

(package! org-ql)

(package! seoul256-theme)

(package! elcord)
