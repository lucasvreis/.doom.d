;;; tangle/feature/org-roam.el -*- lexical-binding: t; -*-
(setq org-roam-directory "~/Lucas/notas")

(defadvice! +org-roam-reuse-windows (&rest r)
  :before #'org-roam-preview-visit
  :before #'org-roam-node-visit
  (when org-roam-buffer-current-node
    (let ((window (get-buffer-window
                    (get-file-buffer
                      (org-roam-node-file org-roam-buffer-current-node)))))
      (when window (select-window window)))))

(defadvice! doom-modeline--buffer-file-name-roam-aware-a (orig-fun)
  :around #'doom-modeline-buffer-file-name ; takes no args
  (if (s-contains-p (expand-file-name org-roam-directory) (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "🢔(\\1-\\2-\\3) "
       (subst-char-in-string ?_ ?  buffer-file-name))
    (funcall orig-fun)))
