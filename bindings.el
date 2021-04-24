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

(general-define-key :keymaps 'lean-mode-map (kbd "M-.") 'lean-find-definition)
