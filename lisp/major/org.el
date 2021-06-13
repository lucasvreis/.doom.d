;;; lisp/major/org.el -*- lexical-binding: t; -*-

(setq org-latex-packages-alist '(("" "tikz" t) ("" "tikz-cd" t))
      org-support-shift-select t
      org-hide-emphasis-markers t)

(add-hook! 'org-mode-hook #'org-appear-mode)

(after! org-appear
  (setq org-appear-autolinks t))


(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)

;; (add-to-list
;;  '+company-backend-alist
;;  ((org-mode company-capf)
;;   (text-mode
;;    (:separate company-dabbrev company-yasnippet company-ispell))
;;   (prog-mode company-capf company-yasnippet)
;;   (conf-mode company-capf company-dabbrev-code company-yasnippet)))
