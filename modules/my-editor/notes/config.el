;;; my-editor/notes/config.el -*- lexical-binding: t; -*-

(use-package nroam
  :after org-roam
  :config
  (add-hook 'org-mode-hook #'nroam-setup-maybe))
