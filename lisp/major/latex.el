;;; lisp/major/latex.el -*- lexical-binding: t; -*-

(setq TeX-save-query nil)
(setq TeX-view-evince-keep-focus t)

(setq TeX-view-program-selection
      '((output-pdf "Zathura")
        (output-pdf "PDF Tools")
        (output-pdf "Evince")
        (output-html "xdg-open")
        (output-pdf "preview-pane")))

(add-hook! (LaTeX-mode latex-mode)
  (LaTeX-math-mode +1)
  (hl-todo-mode +1)
  (auto-fill-mode +1))
