;;; lisp/bindings.el -*- lexical-binding: t; -*-


(map! "C-S-s" 'isearch-forward)
(map! :egni "C-s" 'save-buffer)
(map! :egni "C-/" 'evilnc-comment-or-uncomment-lines)


;; Evil Brazuca ;)
;; no dia em que eu precisar usar teclado americano, eu vou me arrepender...

(map! :map evil-motion-state-map
      "j" 'evil-backward-char
      "k" 'evil-next-line
      "l" 'evil-previous-line
      "ç" 'evil-forward-char)

(map! :map evil-window-map
      ;; Navigation
      "j"       #'evil-window-left
      "k"       #'evil-window-down
      "l"       #'evil-window-up
      "ç"       #'evil-window-right
      "C-j"     #'evil-window-left
      "C-k"     #'evil-window-down
      "C-l"     #'evil-window-up
      "C-ç"     #'evil-window-right
      ;; Swapping windows
      "J"       #'+evil/window-move-left
      "K"       #'+evil/window-move-down
      "L"       #'+evil/window-move-up
      "Ç"       #'+evil/window-move-right)

(map! :i "M-J" 'evil-backward-char
      :i "M-K" 'evil-next-line
      :i "M-L" 'evil-previous-line
      :i "M-Ç" 'evil-forward-char)


(after! treemacs (evil-define-key 'treemacs treemacs-mode-map "l" nil "h" nil))

;; (evil-define-key '(visual normal) Info-mode-map "l" nil)
(map! :map Info-mode-map :vn "l" nil)

(map! :after treemacs
      :map evil-treemacs-state-map
      "j"      #'treemacs-COLLAPSE-action
      "k"      #'treemacs-next-line
      "l"      #'treemacs-previous-line
      "ç"      #'treemacs-RET-action)

(map! :i "C-v" 'yank)

(map! "M-S-<right>" 'windsize-right
      "M-S-<left>" 'windsize-left
      "M-S-<down>" 'windsize-down
      "M-S-<up>" 'windsize-up)

(map! "M-j" 'drag-stuff-down
      "M-k" 'drag-stuff-up)

(map! :leader :desc "Centered mode" "t c" 'olivetti-mode)

(map! :map lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)
