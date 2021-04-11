;;; lisp/yasnippet.el -*- lexical-binding: t; -*-

(add-hook 'snippet-mode-hook
          (lambda () (set (make-local-variable 'require-final-newline) nil)))
