;;; lisp/major/pdf-tools.el -*- lexical-binding: t; -*-

(defvar pdf-scroll-multiplier 2)

(defun pdf-tools--scroll-mul (l)
  (mapcar (lambda (x) (* pdf-scroll-multiplier x)) l))

(advice-add 'pdf-view-next-line-or-next-page :filter-args #'pdf-tools--scroll-mul)
(advice-add 'pdf-view-previous-line-or-previous-page :filter-args #'pdf-tools--scroll-mul)
(advice-add 'image-forward-hscroll :filter-args #'pdf-tools--scroll-mul)
(advice-add 'image-backward-hscroll :filter-args #'pdf-tools--scroll-mul)

(map! :map pdf-view-mode-map
      :n "h" nil
      :n "j" #'image-backward-hscroll
      :n "k" #'evil-collection-pdf-view-next-line-or-next-page
      :n "l" #'evil-collection-pdf-view-previous-line-or-previous-page
      :n "ç" #'image-forward-hscroll)

(after! doom-themes
  (setq pdf-view-midnight-colors (cons (cadr (assq 'fg-alt doom-themes--colors)) (cadr (assq 'bg-alt doom-themes--colors)))))
