;;; lisp/use-packages.el -*- lexical-binding: t; -*-

(use-package prettify-utils
  :after (org latex))

(use-package tree-sitter
  :after doom-first-file-hook
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package mini-frame
;;   :after (:any selectrum vertico)
;;   :config
;;   (mini-frame-mode)
;;   (setq x-gtk-resize-child-frames 'resize-mode)
;;   (setq mini-frame-show-parameters
;;         '((top . 70)
;;           (width . 0.8)
;;           (left . 0.5))
;;         mini-frame-ignore-commands
;;         '(eval-expression
;;           pp-eval-expression
;;           "edebug-eval-expression"
;;           debugger-eval-expression
;;           kill-current-buffer
;;           save-buffers-kill-terminal
;;           evil-ex-search-forward
;;           evil-ex-search-backward
;;           calcDigit-start
;;           calc-algebraic-entry
;;           calc-convert-units
;;           calc-let)))

(use-package scroll-on-drag
  :bind ([down-mouse-2] . #'scroll-on-drag))

(defun yas-get-snippet (mode key)
       (yas--fetch (yas--get-snippet-tables mode) key))

(use-package laas
  :commands (laas-mode))

(use-package which-key-posframe
  :config
  (setq which-key-posframe-poshandler 'posframe-poshandler-frame-bottom-center)
  (which-key-posframe-mode))

(use-package lean4-mode
  :commands (lean4-mode))

(use-package mamimo
  :hook ((org-mode latex-mode markdown-mode) . mamimo-mode))
