;;; lisp/use-packages.el -*- lexical-binding: t; -*-

(use-package prettify-utils
  :after latex)

(use-package tree-sitter
  :after doom-first-file-hook
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package mini-frame
  :after selectrum
  :config
  (mini-frame-mode)
  (setq x-gtk-resize-child-frames 'resize-mode)
  (setq mini-frame-show-parameters
        '((top . 70)
          (width . 0.8)
          (left . 0.5))
        mini-frame-ignore-commands
        '(eval-expression
          "edebug-eval-expression"
          debugger-eval-expression
          save-buffers-kill-terminal
          evil-ex-search-forward
          evil-ex-search-backward
          calcDigit-start
          calc-algebraic-entry
          calc-convert-units
          calc-let)))

(use-package scroll-on-drag
  :bind ([down-mouse-2] . #'scroll-on-drag))
