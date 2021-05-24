;;; my-completion/selectrum/config.el -*- lexical-binding: t; -*-

(use-package! selectrum
  :hook (doom-first-input . selectrum-mode))

(use-package! selectrum-prescient
  :after selectrum
  :config (selectrum-prescient-mode))

(use-package! marginalia
  :after selectrum
  :config
  (marginalia-mode)
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))
