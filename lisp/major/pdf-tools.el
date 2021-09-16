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


(after! doom-themes
  (setq pdf-view-midnight-colors (cons (cadr (assq 'fg doom-themes--colors)) (cadr (assq 'bg doom-themes--colors)))))
