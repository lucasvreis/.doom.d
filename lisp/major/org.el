;;; lisp/major/org.el -*- lexical-binding: t; -*-

(require 'texmathp)

(setq org-latex-packages-alist '(("" "tikz" t) ("" "tikz-cd" t))
      org-support-shift-select t
      org-hide-emphasis-markers t
      org-appear-autolinks t
      org-src-window-setup 'plain
      org-highlight-latex-and-related '(latex script))

(set-popup-rule! "\*Org Src .+\*"
  :size 0.5)

  ;; :actions '(display-buffer-same-window)
  ;; :side 'right)

(add-hook! 'org-mode-hook #'org-appear-mode)

(after! org-appear
  (setq org-appear-autolinks nil))


(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 1.3)

(add-hook! org-mode
  (define-prettify-symbols)
  (setup-latex-prettify)

  (prettify-symbols-mode +1)

  (auto-fill-mode +1)

  (setq real-auto-save-interval 0.2)

  (turn-off-smartparens-mode)
  (turn-on-show-smartparens-mode)

  ;; (flyspell-mode +1) -- todo: set this only for some directories

  (toggle-truncate-lines +1)
  (ws-butler-mode -1))

;; ------------- Org Toc -------------------

(require 'org-toc)

(defun custom-org-toc-cycle-subtree ()
  "Locally cycle a headline through two states: 'children and
'folded"
  (interactive)
  (let ((beg (point))
        (end (save-excursion (end-of-line) (point)))
        (ov (car (overlays-at (point))))
        status)
    (if ov (setq status (overlay-get ov 'status))
      (setq ov (make-overlay beg end)))
    ;; change the folding status of this headline
    (cond ((or (null status) (eq status 'folded))
           (outline-show-children)
           (message "CHILDREN")
           (overlay-put ov 'status 'children))
          (t (hide-subtree)
             (message "FOLDED")
             (overlay-put ov 'status 'folded)))))


(defun custom-org-toc-show (&optional depth position)
  "Show the table of contents of the current Org-mode buffer."
  (interactive "P")
  (if (eq major-mode 'org-mode)
      (progn (setq org-toc-base-buffer (current-buffer))
             (setq org-toc-odd-levels-only org-odd-levels-only))
    (if (eq major-mode 'org-toc-mode)
        (org-pop-to-buffer-same-window org-toc-base-buffer)
      (error "Not in an Org buffer")))
  ;; create the new window display
  (let ((pos (or position
                 (save-excursion
                   (if (org-toc-before-first-heading-p)
                       (progn (re-search-forward org-outline-regexp-bol nil t)
                              (match-beginning 0))
                     (point))))))
    (setq org-toc-cycle-global-status org-cycle-global-status)
    (and (get-buffer "*org-toc*") (kill-buffer "*org-toc*"))
    (select-window
     (display-buffer-in-side-window
      (make-indirect-buffer org-toc-base-buffer "*org-toc*")
      '((side . left)
        (slot . 0))))
    (set-window-dedicated-p nil t)
    ;; make content before 1st headline invisible
    (goto-char (point-min))
    (let* ((beg (point-min))
           (end (and (re-search-forward "^\\*" nil t)
                     (1- (match-beginning 0))))
           (ov (make-overlay beg end))
           (help (format "Table of contents for %s (press ? for a quick help):\n"
                         (buffer-name org-toc-base-buffer))))
      (overlay-put ov 'invisible t)
      (overlay-put ov 'before-string help))
    ;; build the browsable TOC
    (cond (depth
           (let* ((dpth (if org-toc-odd-levels-only
                            (1- (* depth 2)) depth)))
             (org-content dpth)
             (setq org-toc-cycle-global-status
                   `(org-content ,dpth))))
          ((null org-toc-default-depth)
           (if (eq org-toc-cycle-global-status 'overview)
               (progn (org-overview)
                      (setq org-cycle-global-status 'overview)
                      (run-hook-with-args 'org-cycle-hook 'overview))
             (progn (org-overview)
                    ;; FIXME org-content to show only headlines?
                    (org-content)
                    (setq org-cycle-global-status 'contents)
                    (run-hook-with-args 'org-cycle-hook 'contents))))
          (t (let* ((dpth0 org-toc-default-depth)
                    (dpth (if org-toc-odd-levels-only
                              (1- (* dpth0 2)) dpth0)))
               (org-content dpth)
               (setq org-toc-cycle-global-status
                     `(org-content ,dpth)))))
    (goto-char pos))
  (move-beginning-of-line nil)
  (org-toc-mode)
  (hl-line-mode +1)
  (solaire-mode +1)
  (shrink-window-if-larger-than-buffer)
  (setq mode-line-format nil
        cursor-type nil
        buffer-read-only t))

(map! :map 'evil-org-mode-map
      :leader
      :desc "Table of contents"
      "o c" #'custom-org-toc-show)

(map! :map 'org-toc-mode-map
      :n "C-?"  #'org-toc-help
      :n [tab]  #'custom-org-toc-cycle-subtree
      :n "q"    #'kill-current-buffer
      :n "k"    #'org-toc-next
      :n "K"    #'org-toc-forward
      :n "l"    #'org-toc-previous
      :n "L"    #'org-toc-back
      :n "j"    #'hide-subtree
      :n "f"    #'org-toc-follow-mode
      :n "ç"    #'outline-show-children)

(add-to-list
 '+company-backend-alist
 '(org-mode (:separate company-math-symbols-latex company-dabbrev company-ispell company-capf)))

(map! :map 'evil-org-mode-map
      :i "C-l" #'flyspell-correct-move)
