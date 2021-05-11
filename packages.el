;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)


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
(package! windsize)
(package! good-scroll)
;; (package! frame-workflow :recipe (:host github :repo "akirak/frame-workflow"))
;; (package! undo-tree :recipe (:host gitlab :repo "tsc25/undo-tree"))
(package! smooth-scrolling)
(package! mixed-pitch)
(package! nyan-mode)
(package! lsp-treemacs)
(package! benchmark-init)

(package! embark)

;; Tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)

(unpin! company-box)

(package! olivetti)

;; Org-mode
(package! poly-org)
(package! md-roam :recipe (:host github :repo "nobiot/md-roam"))
(package! org-noter)
(package! org-roam-server)
(package! org-marginalia :recipe (:host github :repo "nobiot/org-marginalia"))
(package! org-transclusion :recipe (:host github :repo "nobiot/org-transclusion"))
(package! nroam :recipe (:host github :repo "NicolasPetton/nroam"))
(package! impatient-mode)
;; (package! org-latex-impatient)

;; Latex
(package! ov)
(package! xenops)

;; (package! eaf :recipe (:host github :repo "manateelazycat/emacs-application-framework"))
;; (package! epc)
(package! less-theme :recipe (:host github :repo "nobiot/less-theme"))

(unpin! lsp-mode)
