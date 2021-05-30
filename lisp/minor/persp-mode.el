;;; lisp/minor/persp-mode.el -*- lexical-binding: t; -*-

;; Disables the annoying, big and ugly messages when auto-saving
(advice-add 'persp-parameters-to-savelist :around #'advice--inhibit-message)
