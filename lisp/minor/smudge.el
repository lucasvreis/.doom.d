;;; lisp/minor/smudge.el -*- lexical-binding: t; -*-

(setq smudge-oauth2-client-id     "55d2deb3878f4b73912f72a3a131024c"
      smudge-status-location nil)
      ;; smudge-transport 'dbus)

(define-key smudge-mode-map (kbd "C-c .") 'smudge-command-map)
