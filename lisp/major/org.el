;;; lisp/major/org.el -*- lexical-binding: t; -*-

(setq org-latex-packages-alist '(("" "eulervm" t))
      org-support-shift-select t)

(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)
