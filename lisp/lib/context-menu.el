;;; context-menu.el --- Context menu for Emacs       -*- lexical-binding: t; -*-
;;; (c) Andrea Vettorello CC BY-SA 4.0

(with-eval-after-load "menu-bar"
  (require 'url-util)

  (defvar edit-popup-menu
    '(keymap
      (undo menu-item "Undo" undo
            :enable (and
                     (not buffer-read-only)
                     (not
                      (eq t buffer-undo-list))
                     (if
                         (eq last-command 'undo)
                         (listp pending-undo-list)
                       (consp buffer-undo-list)))
            :keys "")
      (separator-undo menu-item "--")
      (cut menu-item "Cut" clipboard-kill-region
           :enable (use-region-p)
           :keys "")
      (copy-link menu-item "Copy Link"
                 (lambda () (interactive) (kill-new (url-get-url-at-point)))
            :enable (and (url-get-url-at-point))
            :keys "")
      (copy menu-item "Copy" clipboard-kill-ring-save
            :enable (use-region-p)
            :keys "")
      (paste menu-item "Paste" clipboard-yank
             :keys "")
      (paste-from-menu menu-item "Paste from Kill Menu" yank-menu
                       :enable (and
                                (cdr yank-menu)
                                (not buffer-read-only))
                       :help "Select a string from the kill ring and paste it")
      (clear menu-item "Delete" delete-region
             :enable (and mark-active (not buffer-read-only))
             :help "Clear region"
             :keys "Del")
      (separator-select-all menu-item "--")
      (mark-whole-buffer menu-item "Select All" mark-whole-buffer
                         :enable (not (= (buffer-size) 0)))))

  (defun my-context-menu (event)
    "Pop up a context menu."
    (interactive "e")
    (popup-menu edit-popup-menu)))

(provide 'context-menu)
