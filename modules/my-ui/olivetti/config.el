;;; ui/olivetti/config.el -*- lexical-binding: t; -*-

(use-package olivetti
  :init
  (map! :leader :desc "Centered mode" "t e" #'olivetti-mode)

  (add-hook! olivetti-mode
    (if olivetti-mode
        (progn
          (remove-hook! lsp-mode #'lsp-ui-mode)
          (when (bound-and-true-p lsp-mode) (lsp-ui-mode -1)))
      (add-hook! lsp-mode #'lsp-ui-mode)
      (when (bound-and-true-p lsp-mode) (lsp-ui-mode +1))))

  :commands #'olivetti-mode
  :hook (org-mode . olivetti-mode)
  :config
  (setq-default olivetti-body-width 100
                olivetti-recall-visual-line-mode-entry-state nil)

  (after! persp-mode
    (defvar persp--olivetti-buffers-backup nil)

    (defun persp--olivetti-deactivate (fow)
      (dolist (b (mapcar #'window-buffer
                          (window-list (selected-frame)
                                      'no-minibuf)))
        (with-current-buffer b
          (when (eq 'olivetti-split-window-sensibly
                    split-window-preferred-function)
            (push b persp--olivetti-buffers-backup)
            (setq-local split-window-preferred-function nil)
            (olivetti-reset-all-windows)))))

    (defun persp--olivetti-activate (fow)
      (dolist (b persp--olivetti-buffers-backup)
        (with-current-buffer b
          (setq-local split-window-preferred-function
                      'olivetti-split-window-sensibly)))
      (setq persp--olivetti-buffers-backup nil))

    (add-hook 'persp-before-deactivate-functions #'persp--olivetti-deactivate)
    (add-hook 'persp-activated-functions #'persp--olivetti-activate)))
