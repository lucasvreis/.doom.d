;;; lisp/latex.el -*- lexical-binding: t; -*-

(setq TeX-save-query nil)
(setq TeX-view-evince-keep-focus t)


(setq TeX-view-program-list
  '(("Zathura2"
     ("emacswinno=`xdotool getwindowfocus` \; zathura %o \; sleep 0.1\; xdotool windowactivate $emacswinno"
      (mode-io-correlate " --synctex-forward %n:0:\"%b\" -x \"emacsclient +%{line} %{input}\""))
     "zathura")))

(setq TeX-view-program-selection
      '((output-pdf "Zathura2")
        (output-pdf "PDF Tools")
        ((output-dvi has-no-display-manager)
         "dvi2tty")
        ((output-dvi style-pstricks)
         "dvips and gv")
        (output-dvi "xdvi")
        (output-pdf "Evince")
        (output-html "xdg-open")
        (output-pdf "preview-pane")))


(add-hook! 'TeX-mode-hook
  (lambda ()
    (add-hook 'after-change-functions
              (lambda (start end oldlen)
                (when (= (- end start) 1)
                  (let ((char-point
                         (buffer-substring-no-properties start end)))
                    (when (or (string= char-point "}")
                              (string= char-point ")"))
                      (TeX-fold-paragraph))))
                t t)))
  ;; (load-theme 'tao-yang :no-confirm nil)
  (LaTeX-math-mode +1)
  (hl-todo-mode +1)
  (delete '("∈" ("in")) LaTeX-fold-math-spec-list)
  (auto-fill-mode +1)
  (+word-wrap-mode +1))

;; Huge HACK:
(setq TeX-fold-macro-spec-list
      '(("[f]"
         ("footnote" "marginpar"))
        ("[c]"
         ("cite"))
        ("[l]"
         ("label"))
        ("[r]"
         ("ref" "pageref" "eqref"))
        ("[i]"
         ("index" "glossary"))
        ("[1]:||*"
         ("item"))
        ("..."
         ("dots"))
        ("(C)"
         ("copyright"))
        ("(R)"
         ("textregistered"))
        ("TM"
         ("texttrademark"))
        (1
         ("part" "chapter" "section" "subsection" "subsubsection" "paragraph" "subparagraph" "part*" "chapter*" "section*" "subsection*" "subsubsection*" "paragraph*" "subparagraph*" "emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt" "textbf" "textsc" "textup"))
        ("~\[[1]\]||~"
         ("["))
        ("~"
         ("]"))
        ("`\[[1]\]||`"
         ("("))
        ("`"
         (")"))))


(setq TeX-fold-math-spec-list
      '(("ℝ"
         ("RR" "Reals"))
        ("∈ \[[1]\]||∈"
         ("in"))
        ("√\{{1}\}||√"
         ("sqrt"))
        ("\{{1}／{2}\}||\\frac"
         ("frac"))
        ("ₗ"
         ("left"))
        ("ᵣ"
         ("right"))))
