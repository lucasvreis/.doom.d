(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner
          '("" ""
            "   o__  __o   \\o__ __o__ __o      o__ __o/      __o__      __o__"
            "  /v      |>   |     |     |>    /v     |      />  \\      />  \\ "
            " />      //   / \\   / \\   / \\   />     / \\   o/           \\o    "
            " \\o    o/     \\o/   \\o/   \\o/   \\      \\o/  <|             v\\   "
            "  v\\  /v __o   |     |     |     o      |    \\\\             <\\  "
            "   <\\/> __/>  / \\   / \\   / \\    <\\__  / \\    _\\o__</  _\\o__</  "
            ""))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1))

(remove-hook 'window-setup-hook #'doom-display-benchmark-h)

(setq all-the-icons-scale-factor 0.88)

(custom-set-faces!

  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant oblique)

  '(doom-dashboard-banner
    :inherit font-lock-comment-face
    :slant normal)

  '(doom-modeline-buffer-modified :foreground "orange")
  '(doom-modeline-info :foreground "white")
  '(fixed-pitch-serif  :family "Noto Sans Mono"))
