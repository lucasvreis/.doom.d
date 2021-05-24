;;; ui/olivetti/config.el -*- lexical-binding: t; -*-

(use-package! olivetti
  :hook ((latex-mode LaTeX-mode text-mode) . olivetti-mode)
  :config
  (setq-default olivetti-body-width 100
                olivetti-recall-visual-line-mode-entry-state nil)
  (add-hook! (latex-mode LaTeX-mode-hook)
    (unless (bound-and-true-p 'polymode-mode)
      (setq-local olivetti-body-width  80
                  display-line-numbers nil))))
