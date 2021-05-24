;;; lisp/bindings.el -*- lexical-binding: t; -*-

;; maps

(map! "C-S-s" 'isearch-forward)
(map! :egni "C-s" 'save-buffer)
(map! :egni "C-/" 'evilnc-comment-or-uncomment-lines)

(map! :i "C-v" 'yank)

(map! "M-S-<right>" 'windsizOBe-right
      "M-S-<left>" 'windsize-left
      "M-S-<down>" 'windsize-down
      "M-S-<up>" 'windsize-up)

(map! "M-j" 'drag-stuff-down
      "M-k" 'drag-stuff-up)

(map! :leader :desc "Centered mode" "t c" 'olivetti-mode)

(map! :map lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)
