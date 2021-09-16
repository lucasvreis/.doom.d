;;; tangle/minor/evil.el -*- lexical-binding: t; -*-
(defadvice! ~evil-shift-width-elisp-advice (fun &rest r)
  :around #'evil-shift-width-elisp-advice
  (if (eq major-mode 'emacs-lisp-mode)
      (setq evil-shift-width 2)
    (apply fun r)))

(defun evil-mc/toggle-cursor-on-click (event)
  "Add a cursor where you click, or remove a fake cursor that is
already there."
  (interactive "e")
  (mouse-minibuffer-check event)
  (require 'evil-mc)
  ;; Use event-end in case called from mouse-drag-region.
  ;; If EVENT is a click, event-end and event-start give same value.
  (let ((position (event-end event)))
    (if (not (windowp (posn-window position)))
        (error "Position not in text area of window"))
    (select-window (posn-window position))
    (let ((pt (posn-point position)))
      (if (numberp pt)
          ;; is there a fake cursor with the actual *point* right where we are?
          (unless (evil-mc-undo-cursor-at-pos pt)
            (save-excursion
              (goto-char pt)
              (evil-mc-make-cursor-here)))))))
(map! "C-<down-mouse-1>" nil)
(map! "C-<mouse-1>" #'evil-mc/toggle-cursor-on-click)

(defun evil-org--parse-headline ()
  (save-excursion
    (end-of-line)
    (outline-previous-heading)
    (skip-chars-forward "* \t")
    (let* ((todo-start     (point))
           (todo-end1      (and org-todo-regexp
                                (let (case-fold-search) (looking-at (concat org-todo-regexp " ")))
                                (goto-char (1- (match-end 0)))))
           (todo-end2      (when todo-end1 (skip-chars-forward " \t") (point)))
           (priority-start (point))
           (priority-end   (when (looking-at "\\[#.\\][ \t]*") (goto-char (match-end 0))))
           (_              (and (let (case-fold-search) (looking-at org-comment-string))
                                (goto-char (match-end 0))))
           (title-start    (point))
           (tags-start     (when (re-search-forward "[ \t]+\\(:[[:alnum:]_@#%:]+:\\)[ \t]*$"
                                                    (line-end-position) 'move)
                             (goto-char (match-beginning 0))
                             (match-beginning 1)))
           (title-end      (point)))
      (list todo-start todo-end1 todo-end2 priority-start
            priority-end title-start title-end
            tags-start (line-end-position)))))

(evil-define-text-object evil-org-headline (count &optional beg end type)
  "Select the current org heading" :jump t
  (save-excursion
    (end-of-line)
    (outline-previous-heading)
    (list (line-beginning-position) (line-end-position))))

(evil-define-text-object evil-org-headline-title (c &rest _)
  "Select the title text in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (list (nth 5 parse) (nth 6 parse))))

(evil-define-text-object evil-org-headline-todo (c &rest _)
  "Select the todo entry in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (list (nth 0 parse) (nth 2 parse))))

(evil-define-text-object evil-org-headline-inner-todo (c &rest _)
  "Select the inner todo entry in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (list (nth 0 parse) (nth 1 parse))))

(evil-define-text-object evil-org-headline-priority (c &rest _)
  "Select the priority entry in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (list (nth 3 parse) (nth 4 parse))))

(evil-define-text-object evil-org-headline-tags (c &rest _)
  "Select the tags in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (list (nth 6 parse) (nth 8 parse))))

(evil-define-text-object evil-org-headline-inner-priority (c &rest r)
  "Select the inner part of priority in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (when (nth 4 parse)
      (let ((p (+ 2 (nth 3 parse)))) (list p (1+ p))))))

(evil-define-text-object evil-org-headline-inner-tags (c &rest _)
  "Select the inner part of tags in the current org heading" :jump t
  (let ((parse (evil-org--parse-headline)))
    (when (nth 7 parse)
      (list (1+ (nth 7 parse)) (1- (nth 8 parse))))))

(map! :map 'evil-inner-text-objects-map
      "h h" #'evil-org-headline-title
      "h t" #'evil-org-headline-inner-todo
      "h p" #'evil-org-headline-inner-priority
      "h a" #'evil-org-headline-inner-tags)

(map! :map 'evil-outer-text-objects-map
      "h h" #'evil-org-headline
      "h t" #'evil-org-headline-todo
      "h p" #'evil-org-headline-priority
      "h a" #'evil-org-headline-tags)
