;;; lisp/major/latex.el -*- lexical-binding: t; -*-

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
        (output-pdf "Evince")
        (output-html "xdg-open")
        (output-pdf "preview-pane")))

(add-hook! (LaTeX-mode latex-mode)
  (LaTeX-math-mode +1)
  (hl-todo-mode +1)
  (auto-fill-mode +1)
  (prettify-symbols-mode +1))

(after! prettify-utils
  (load! "script/prettify-latex-autogen" doom-private-dir)
  (setq tex--prettify-symbols-alist
        (append
          '(("\\left" . ?ₗ)
            ("\\right" . ?ᵣ)
            ("_n" . ?ₙ))
          (prettify-utils-generate
           ("^{-1}" "⁻¹")
           ("_{i=1}" "ᵢ₌₁")
           ("\\not\\subset" "⊄"))
          prettify-mode--latex-autogen-alist
          (bound-and-true-p tex--prettify-symbols-alist))))
