;;; lisp/minor/evil.el -*- lexical-binding: t; -*-

(setq evil-shift-round nil
      evil-cross-lines t
      evil-respect-visual-line-mode t)

(defun evil-shift-width-elisp-advice (fun &rest r)
  (if (eq major-mode 'emacs-lisp-mode)
      (setq evil-shift-width 2)
    (apply fun r)))

(advice-add 'doom--setq-evil-shift-width-for-after-change-major-mode-h
            :around #'evil-shift-width-elisp-advice)

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
