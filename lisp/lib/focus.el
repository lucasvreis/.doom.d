;;; focus.el --- Dim the font color of text in surrounding sections  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Lars Tveito

;; Author: Lars Tveito <larstvei@ifi.uio.no>
;; URL: http://github.com/larstvei/Focus
;; Created: 11th May 2015
;; Version: 1.0.0
;; Package-Requires: ((emacs "24.3") (cl-lib "0.5"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Focus provides `focus-mode` that dims the text of surrounding sections,
;; similar to [iA Writer's](https://ia.net/writer) Focus Mode.
;;
;; Enable the mode with `M-x focus-mode'.

;;; Code:

(require 'cl-lib)
(require 'dimmer)
(require 'org-element)
(require 'thingatpt)

(defgroup focus ()
  "Dim the font color of text in surrounding sections."
  :group 'font-lock
  :prefix "focus-")

(defcustom focus-mode-to-thing '((prog-mode . defun)
                                 (text-mode . paragraph)
                                 (org-mode . org-element))
  "An associated list between mode and thing.

A thing is defined in thingatpt.el; the thing determines the
narrowness of the focused section.

Note that the order of the list matters. The first mode that the
current mode is derived from is used, so more modes that have
many derivatives should be placed by the end of the list.

Things that are defined include `symbol', `list', `sexp',
`defun', `filename', `url', `email', `word', `sentence',
`whitespace', `line', and `page'."
  :type '(repeat symbol)
  :group 'focus)

(defcustom focus-read-only-blink-seconds 1
  "The duration of a cursor blink in `focus-read-only-mode'."
  :type '(float)
  :group 'focus)

(defcustom focus-fraction 0.5
  "Determines the amount of dimness in out of focus sections (0.0 – 1.0)."
  :type '(float)
  :group 'focus)

(defface focus-unfocused nil
  "The face that overlays the unfocused area."
  :group 'focus)

(defface focus-focused nil
  "The face that overlays the focused area."
  :group 'focus)

(defvar focus-cursor-type cursor-type
  "Used to restore the users `cursor-type'.")

(defvar-local focus-current-thing nil
  "Overrides the choice of thing dictated by `focus-mode-to-thing' if set.")

(defvar-local focus-buffer nil
  "Local reference to the buffer focus functions operate on.")

(defvar-local focus-focused-overlays nil
  "The overlays that undims the unfocused area.")

(defvar-local focus-pin-bounds nil
  "Bounds set by `focus-pin'.")

(defvar-local focus-last-bounds nil
  "Used to identify changes in `focus-bounds'.")

(defvar-local focus-last-background nil
  "Used to identify changes in the background.")

(defvar-local focus-read-only-blink-timer nil
  "Timer started from `focus-read-only-cursor-blink'.
The timer calls `focus-read-only-hide-cursor' after
`focus-read-only-blink-seconds' seconds.")


(defun focus-get-thing ()
  "Return the current thing, based on `focus-mode-to-thing'."
  (or focus-current-thing
      (let* ((modes (mapcar 'car focus-mode-to-thing))
             (mode  (or (cl-find major-mode modes)
                        (apply #'derived-mode-p modes))))
        (if mode (cdr (assoc mode focus-mode-to-thing)) 'sentence))))

(defun focus-org-element-bounds ()
  "Extract bounds from `org-element-at-point'"
  (let* ((elem (org-element-at-point))
         (beg (org-element-property :begin elem))
         (end (org-element-property :end elem)))
    (and beg end (cons beg end))))

(put 'org-element 'bounds-of-thing-at-point
     #'focus-org-element-bounds)

(defun focus-bounds ()
  "Return the current bounds, based on `focus-get-thing'."
  (or focus-pin-bounds
      (bounds-of-thing-at-point (focus-get-thing))))

(defun focus-make-focused-face (fg)
  "Combine foreground color FG with the `focus-focused` face."
  (if (and fg (not (color-defined-p (face-attribute 'focus-focused :foreground))))
      (plist-put (face-attr-construct 'focus-focused)
                 :foreground fg)
    'focus-focused))

(defun focus-foreground-from-face (face)
  "Return foreground color for FACE, or 'default if nil."
  (let* ((default (face-attribute 'default :foreground))
         (color (cond
                 ((and (listp face) (facep (car face)))
                  (face-attribute (car face) :foreground nil (cdr face)))
                 ((facep face)
                  (face-attribute face :foreground nil 'default))
                 (default))))
    (if (color-defined-p color) color default)))

(defun focus-undim-area (low high)
  "Restore original colors between LOW and HIGH.

Returns the list of added overlays."
  (while (< low high)
    (let ((next (next-single-property-change low 'face nil high)))
      (if (invisible-p low)
          (setq low (next-single-char-property-change low 'invisible nil high))
        (let* ((face (get-text-property low 'face))
               (fg (focus-foreground-from-face face))
               (focused-face (focus-make-focused-face fg))
               (o (make-overlay low next)))
          (overlay-put o 'face focused-face)
          (push o focus-focused-overlays)
          (setq low next))))))

(defun focus-remove-focused-overlays ()
  (while focus-focused-overlays
    (delete-overlay (pop focus-focused-overlays))))

(defun focus-move-focus ()
  "Move the focused section according to `focus-bounds'.

If `focus-mode' is enabled, this function is added to
`post-command-hook'."
  (with-current-buffer focus-buffer
    (let* ((bg (face-background 'default))
           (bounds (focus-bounds)))
      (when (and bounds (or (not (equal bg focus-last-background))
                            (not (equal bounds focus-last-bounds))))
        (let ((low (car bounds))
              (high (cdr bounds)))
          (focus-remove-focused-overlays)
          (focus-undim-area low high)))
      (setq focus-last-background bg)
      (setq focus-last-bounds bounds))))

(defun focus-init ()
  "This function run when command `focus-mode' is enabled.

It sets the `focus-pre-overlay', `focus-min-overlay', and
`focus-post-overlay' to overlays; these are invisible until
`focus-move-focus' runs. It adds `focus-move-focus' to
`post-command-hook'."
  (focus-cleanup)
  (setq focus-buffer (current-buffer))
  (dimmer-dim-buffer focus-buffer focus-fraction)
  (add-hook 'post-command-hook 'focus-move-focus t t)
  ;; (add-hook 'window-scroll-functions 'focus-move-focus t t)
  (add-hook 'change-major-mode-hook 'focus-cleanup t t)
  (focus-move-focus))

(defun focus-cleanup ()
  "This function is run when command `focus-mode' is disabled.

Overlays are deleted. `focus-move-focus' is removed from
`post-command-hook'."
  (let ((overlays focus-focused-overlays))
    (mapc (lambda (o) (and (overlayp o) (delete-overlay o))) overlays)
    (remove-hook 'post-command-hook 'focus-move-focus t)
    (dimmer-restore-buffer (current-buffer))
    ;; (remove-hook 'window-scroll-functions 'focus-move-focus t)
    (setq focus-focused-overlays nil
          focus-last-bounds nil
          focus-last-background nil)))

(defun focus-goto-thing (bounds)
  "Move point to the middle of BOUNDS."
  (when bounds
    (goto-char (/ (+ (car bounds) (cdr bounds)) 2))
    (recenter nil)))

(defun focus-change-thing ()
  "Adjust the narrowness of the focused section for the current buffer.

The variable `focus-mode-to-thing' dictates the default thing
according to major-mode. If `focus-current-thing' is set, this
default is overwritten. This function simply helps set the
`focus-current-thing'."
  (interactive)
  (let* ((candidates '(defun line list org-element paragraph sentence sexp symbol word))
         (thing (completing-read "Thing: " candidates)))
    (setq focus-current-thing (intern thing))))

(defun focus-pin ()
  "Pin the focused section to its current location or the region, if active."
  (interactive)
  (when (and (bound-and-true-p focus-mode)
             (region-active-p))
    (setq focus-pin-bounds (cons (region-beginning) (region-end)))))

(defun focus-unpin ()
  "Unpin the focused section."
  (interactive)
  (when (bound-and-true-p focus-mode)
    (setq focus-pin-bounds nil)))

(defun focus-next-thing (&optional n)
  "Move the point to the middle of the Nth next thing."
  (interactive "p")
  (let ((current-bounds (focus-bounds))
        (thing (focus-get-thing)))
    (forward-thing thing n)
    (when (equal current-bounds (focus-bounds))
      (forward-thing thing (cl-signum n)))
    (focus-goto-thing (focus-bounds))))

(defun focus-prev-thing (&optional n)
  "Move the point to the middle of the Nth previous thing."
  (interactive "p")
  (focus-next-thing (- n)))

(defun focus-read-only-hide-cursor ()
  "Hide the cursor.
This function is triggered by the `focus-read-only-blink-timer',
when `focus-read-only-mode' is activated."
  (with-current-buffer focus-buffer
    (when (and (bound-and-true-p focus-read-only-mode)
               (not (null focus-read-only-blink-timer)))
      (setq focus-read-only-blink-timer nil)
      (setq cursor-type nil))))

(defun focus-read-only-cursor-blink ()
  "Make the cursor visible for `focus-read-only-blink-seconds'.
This is added to the `pre-command-hook' when
`focus-read-only-mode' is active."
  (with-current-buffer focus-buffer
    (when (and (bound-and-true-p focus-read-only-mode)
               (not (member last-command '(focus-next-thing focus-prev-thing))))
      (when focus-read-only-blink-timer (cancel-timer focus-read-only-blink-timer))
      (setq cursor-type focus-cursor-type)
      (setq focus-read-only-blink-timer
            (run-at-time focus-read-only-blink-seconds nil
                         'focus-read-only-hide-cursor)))))

(defun focus-read-only-init ()
  "Run when `focus-read-only-mode' is activated.
Enables `read-only-mode', hides the cursor and adds
`focus-read-only-cursor-blink' to `pre-command-hook'.
Also `focus-read-only-terminate' is added to the `kill-buffer-hook'."
  (read-only-mode 1)
  (setq cursor-type nil
        focus-buffer (current-buffer))
  (add-hook 'pre-command-hook 'focus-read-only-cursor-blink nil t)
  (add-hook 'kill-buffer-hook 'focus-read-only-terminate nil t))

(defun focus-read-only-terminate ()
  "Run when `focus-read-only-mode' is deactivated.
Disables `read-only-mode' and shows the cursor again.
It cleans up the `focus-read-only-blink-timer' and hooks."
  (read-only-mode -1)
  (setq cursor-type focus-cursor-type)
  (when focus-read-only-blink-timer
    (cancel-timer focus-read-only-blink-timer))
  (setq focus-read-only-blink-timer nil)
  (remove-hook 'pre-command-hook 'focus-read-only-cursor-blink t)
  (remove-hook 'kill-buffer-hook 'focus-read-only-terminate t))

(defun focus-turn-off-focus-read-only-mode ()
  "Turn off `focus-read-only-mode'."
  (interactive)
  (focus-read-only-mode -1))

;;;###autoload
(define-minor-mode focus-mode
  "Dim the font color of text in surrounding sections."
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-q") 'focus-read-only-mode)
            map)
  (if focus-mode (focus-init) (focus-cleanup)))

;;;###autoload
(define-minor-mode focus-read-only-mode
  "A read-only mode optimized for `focus-mode'."
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "n") 'focus-next-thing)
            (define-key map (kbd "SPC") 'focus-next-thing)
            (define-key map (kbd "p") 'focus-prev-thing)
            (define-key map (kbd "S-SPC") 'focus-prev-thing)
            (define-key map (kbd "i") 'focus-turn-off-focus-read-only-mode)
            (define-key map (kbd "q") 'focus-turn-off-focus-read-only-mode)
            map)
  (when cursor-type
    (setq focus-cursor-type cursor-type))
  (if focus-read-only-mode (focus-read-only-init) (focus-read-only-terminate)))

(provide 'focus)
;;; focus.el ends here
