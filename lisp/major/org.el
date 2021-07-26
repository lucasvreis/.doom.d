;;; lisp/major/org.el -*- lexical-binding: t; -*-

(require 'texmathp)

(setq org-latex-packages-alist '(("" "tikz" t) ("" "tikz-cd" t))
      org-support-shift-select t
      org-hide-emphasis-markers t
      org-appear-autolinks t
      org-src-window-setup 'plain
      org-highlight-latex-and-related '(latex script))

(set-popup-rule! "\*Org Src .+\*"
  :size 0.5)

  ;; :actions '(display-buffer-same-window)
  ;; :side 'right)

(add-hook! 'org-mode-hook #'org-appear-mode)

(after! org-appear
  (setq org-appear-autolinks nil))


(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)

(add-hook! org-mode
  (auto-fill-mode +1)

  (setq real-auto-save-interval 0.2)

  (turn-off-smartparens-mode)
  (turn-on-show-smartparens-mode)

  ;; (flyspell-mode +1) -- todo: set this only for some directories

  (ws-butler-mode -1))

(add-to-list
 '+company-backend-alist
 '(org-mode (:separate company-math-symbols-latex company-dabbrev company-ispell company-capf)))

(map! :map 'evil-org-mode-map
      :i "C-l" #'flyspell-correct-move)
