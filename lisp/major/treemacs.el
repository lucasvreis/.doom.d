;;; lisp/lean.el -*- lexical-binding: t; -*-

(setq +treemacs-git-mode 'deferred
      treemacs-follow-after-init t
      treemacs-width 26
      doom-themes-treemacs-theme "doom-colors"
      doom-themes-treemacs-bitmap-indicator-width 1
      doom-themes-treemacs-enable-variable-pitch nil)

(add-hook! 'treemacs-mode-hook #'treemacs-follow-mode)
