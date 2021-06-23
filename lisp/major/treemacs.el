;;; -*- lexical-binding: t; -*-

(setq +treemacs-git-mode 'deferred
      treemacs-width 26
      treemacs-follow-after-init t
      treemacs-show-hidden-files nil
      doom-themes-treemacs-theme "doom-colors"
      doom-themes-treemacs-bitmap-indicator-width 1
      doom-themes-treemacs-line-spacing 0
      doom-themes-treemacs-enable-variable-pitch t)

(unless (display-graphic-p)
  (setq doom-themes-treemacs-theme "Default"))

(after! lsp-treemacs
  (load-library "doom-themes-ext-treemacs"))

(advice-add 'treemacs-create-dir :after #'treemacs-refresh) ;; refresh after creating new dir

;; This seems to give me problems:
;; (add-hook! 'treemacs-mode-hook
;;            #'treemacs-follow-mode)

(defvar treemacs-file-ignore-regexps '()
  "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")

(defun treemacs-file-ignore-generate-regexps ()
  "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
  (setq treemacs-file-ignore-regexps (mapcar 'wildcard-to-regexp treemacs-file-ignore-globs)))


(defun treemacs-ignore-filter (file full-path)
  "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
  (or (member (file-name-extension file) treemacs-file-ignore-extensions)
      (let ((ignore-file nil))
        (dolist (regexp treemacs-file-ignore-regexps ignore-file)
          (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))

(add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter)

(add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)

(add-hook! 'treemacs-mode-hook
  (hack-dir-local-variables-non-file-buffer)
  (unless (equal treemacs-file-ignore-globs '())
    (treemacs-file-ignore-generate-regexps)))
