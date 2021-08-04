;;; tangle/major/org.el -*- lexical-binding: t; -*-
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

(add-hook! org-mode
    (auto-fill-mode +1)
    (setq-local real-auto-save-interval 0.2)
    (turn-off-smartparens-mode)
    (turn-on-show-smartparens-mode)
    (ws-butler-mode -1)
    (my/org-hide-properties)
    )

(set-popup-rule! "\*Org Src .+\*"
  :size 0.5)

(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)

(add-to-list
 '+company-backend-alist
 '(org-mode (:separate company-math-symbols-latex company-dabbrev company-ispell company-capf)))

(map! :map 'evil-org-mode-map
      :i "C-l" #'flyspell-correct-move)

(after! ox-latex
  (add-to-list 'org-latex-classes
            '("report-noparts"
                "\\documentclass{report}"
                ("\\chapter{%s}" . "\\chapter*{%s}")
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(map! :mode 'org-mode :g "C-S-s" #'org-latex-export-to-pdf)

(defun my/org-hide-properties ()
  "Hide all org-mode headline property drawers in buffer. Could be
slow if it has a lot of overlays."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:properties:\n\\( *:.+?:.*\n\\)+ *:end:\n" nil t)
      (let ((ov_this (make-overlay (match-beginning 0) (match-end 0))))
        (overlay-put ov_this 'display "")
        (overlay-put ov_this 'hidden-prop-drawer t))))
  (put 'org-toggle-properties-hide-state 'state 'hidden))

(defun my/org-show-properties ()
  "Show all org-mode property drawers hidden by org-hide-properties."
  (interactive)
  (remove-overlays (point-min) (point-max) 'hidden-prop-drawer t)
  (put 'org-toggle-properties-hide-state 'state 'shown))

(defun my/org-toggle-properties ()
  "Toggle visibility of property drawers."
  (interactive)
  (if (eq (get 'org-toggle-properties-hide-state 'state) 'hidden)
      (org-show-properties)
    (org-hide-properties)))
