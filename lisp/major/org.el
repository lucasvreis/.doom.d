;;; lisp/major/org.el -*- lexical-binding: t; -*-

(setq org-latex-packages-alist '(("" "tikz" t) ("" "tikz-cd" t))
      org-support-shift-select t
      org-hide-emphasis-markers t
      org-startup-folded t)

(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)

(defun org-toggle-emphasis ()
  "Toggle hiding/showing of org emphasize markers."
  (interactive)
  (if org-hide-emphasis-markers
      (set-variable 'org-hide-emphasis-markers nil)
    (set-variable 'org-hide-emphasis-markers t)))
(map! :map org-mode-map "C-c e" 'org-toggle-emphasis)
