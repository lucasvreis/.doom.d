;;; lisp/minor/solaire.el -*- lexical-binding: t; -*-

(defvar solaire-mode-auto-swap-bg nil)

(after! solaire-mode
  ;; Remove old hacks; no longer necessary
  (advice-remove #'org-format-latex #'solaire-mode--org-latex-bg)
  (advice-remove #'org-create-formula-image #'solaire-mode--org-latex-bg)
  (advice-remove #'org--make-preview-overlay #'solaire-mode--org-put-bg-for-preview-overlay)

  ;; Flip solaire-mode's strategy of remapping faces in real buffers to
  ;; remapping faces is unreal buffers (like the minibuffer or sidebars).
  ;;
  ;; This resolves a) its performance issues, b) its image background issues
  ;; (e.g. in org buffers), and c) any face-remap conflicts with other packages,
  ;; like mixed-pitch, at the cost of having these issues in unreal buffers
  ;; (like the minibuffer or dashboard), which is far better.
  (defun solaire-mode-toggle-in-minibuffer-h ()
    (dolist (buf '(" *Minibuf-0*" " *Minibuf-1*"
                   " *Echo Area 0*" " *Echo Area 1*"))
      (with-current-buffer (get-buffer-create buf)
        (if solaire-global-mode
            (when (= (buffer-size) 0)
              (insert " "))
          (erase-buffer))
        (solaire-mode (if solaire-global-mode +1 -1)))))
  (add-hook 'solaire-global-mode-hook #'solaire-mode-toggle-in-minibuffer-h)

  (defadvice! fixed-turn-on-solaire-mode ()
    :override #'turn-on-solaire-mode
    (interactive)
    (and (not solaire-mode)
         (or (minibufferp)
             (not (funcall solaire-mode-real-buffer-fn)))
         (solaire-mode +1)))

  (defadvice! fixed-create-image (image)
    :filter-return #'create-image
    (when (bound-and-true-p solaire-mode)
      (plist-put (cdr image) :background (face-background 'solaire-default-face nil t)))
    image))
