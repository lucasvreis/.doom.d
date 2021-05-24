;;; lisp/use-packages.el -*- lexical-binding: t; -*-

(use-package! prettify-utils)

(use-package! smudge)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! embark
  :after ivy
  :bind (:map minibuffer-local-map
         ("C-o" . embark-act)
         :map embark-file-map
         ("j" . dired-jump)))

(use-package! org-marginalia
  :hook (org-mode . org-marginalia-mode))
