(map! "C-S-s" 'isearch-forward)
(map! "C-s" 'save-buffer)

(map! :m "ç" 'god-execute-with-current-bindings)
(map! :i "C-ç" 'god-execute-with-current-bindings)

(map! "M-S-<right>" 'windsize-right)
(map! "M-S-<left>" 'windsize-left)
(map! "M-S-<down>" 'windsize-down)
(map! "M-S-<up>" 'windsize-up)

(map! "M-j" 'drag-stuff-down)
(map! "M-k" 'drag-stuff-up)

(map! :leader :desc "Toggle centaur tabs" "t t" 'centaur-tabs-local-mode)
(map! :gnvi "C-<tab>" 'centaur-tabs-forward
      :g "C-<iso-lefttab>" 'centaur-tabs-backward)

(map! :map 'lean-mode-map "M-." 'lean-find-definition)

(map! :map TeX-mode-map "C-S-s" 'TeX-command-run-all)
