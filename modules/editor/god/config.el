;;; editor/god/config.el -*- lexical-binding: t; -*-

(use-package! god-mode
  :config
  ;; (add-hook 'post-command-hook #'+god--configure-cursor-and-modeline-h)
  ;; (add-hook 'overwrite-mode-hook #'+god--toggle-on-overwrite-h)

  (after! which-key
    (which-key-enable-god-mode-support)))
