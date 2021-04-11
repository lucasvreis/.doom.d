(map! :m "ç" 'god-execute-with-current-bindings)
(map! :i "C-ç" 'god-execute-with-current-bindings)

(map! "M-S-<right>" 'windsize-right)
(map! "M-S-<left>" 'windsize-left)
(map! "M-S-<down>" 'windsize-down)
(map! "M-S-<up>" 'windsize-up)

(map! "M-J" 'drag-stuff-down)
(map! "M-K" 'drag-stuff-up)

(general-define-key :keymaps 'lean-mode-map (kbd "M-.") 'lean-find-definition)
