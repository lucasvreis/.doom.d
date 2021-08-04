;;; tangle/minor/centaur-tabs.el -*- lexical-binding: t; -*-
(defun centaur-tabs-buffer-groups ()
  "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
  (list
   (cond
    ((derived-mode-p 'prog-mode)
     "Editing")
    ((derived-mode-p 'dired-mode)
     "Dired")
    ((memq major-mode '(helpful-mode
                        help-mode))
     "Help")
    ((memq major-mode '(org-mode
                        org-agenda-clockreport-mode
                        org-src-mode
                        org-agenda-mode
                        org-beamer-mode
                        org-indent-mode
                        org-bullets-mode
                        org-cdlatex-mode
                        org-agenda-log-mode
                        diary-mode))
     "OrgMode")
    ((memq major-mode '(vterm-mode
                        term-mode
                        julia-repl-mode))
     "TermMode")
    ((or (string-equal "*" (substring (buffer-name) 0 1))
         (memq major-mode '(magit-process-mode
                            magit-status-mode
                            magit-diff-mode
                            magit-log-mode
                            magit-file-mode
                            magit-blob-mode
                            magit-blame-mode)))
     "Emacs")
    (t
     (centaur-tabs-get-group-name (current-buffer))))))


(setq centaur-tabs-style "bar"
      centaur-tabs-set-bar nil
      centaur-tabs-height 36
      centaur-tabs-plain-icons t
      centaur-tabs-label-fixed-length 10)

(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))
