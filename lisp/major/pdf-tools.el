;;; lisp/major/pdf-tools.el -*- lexical-binding: t; -*-

(defvar pdf-scroll-multiplier 2)

(defun pdf-tools--scroll-mul (l)
  (mapcar (lambda (x) (* pdf-scroll-multiplier x)) l))

(advice-add 'pdf-view-next-line-or-next-page :filter-args #'pdf-tools--scroll-mul)
(advice-add 'pdf-view-previous-line-or-previous-page :filter-args #'pdf-tools--scroll-mul)
(advice-add 'image-forward-hscroll :filter-args #'pdf-tools--scroll-mul)
(advice-add 'image-backward-hscroll :filter-args #'pdf-tools--scroll-mul)

(defun pdf-tools-center-page ()
  (interactive)
  (let* ((image (image-get-display-property))
         (edges (window-inside-edges))
         (win-width (- (nth 2 edges) (nth 0 edges)))
         (img-width (ceiling (car (image-display-size image)))))
    (image-set-window-hscroll (max 0 (/ (- img-width win-width -1) 2)))))

(advice-add 'pdf-view-shrink :after (lambda (_) (pdf-tools-center-page)))
(advice-add 'pdf-view-enlarge :after (lambda (_) (pdf-tools-center-page)))

(map! :map pdf-view-mode-map
      :n "h" #'pdf-tools-center-page
      :n "j" #'image-backward-hscroll
      :n "k" #'evil-collection-pdf-view-next-line-or-next-page
      :n "l" #'evil-collection-pdf-view-previous-line-or-previous-page
      :n "ç" #'image-forward-hscroll
      :n "C-k" #'pdf-view-next-page-command
      :n "C-l" #'pdf-view-previous-page-command)

(after! doom-themes
  (setq pdf-view-midnight-colors (cons (cadr (assq 'fg-alt doom-themes--colors)) (cadr (assq 'bg-alt doom-themes--colors)))))
