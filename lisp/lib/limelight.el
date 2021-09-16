;;; limelight.el --- Limelight but for Emacs

;;; Commentary:
;;

(require 'dimmer)
(require 'cl-lib)
(require 'thingatpt)

(defcustom focus-mode-to-thing '((prog-mode . defun) (text-mode . sentence))
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

(defvar-local focus-current-thing nil
  "Overrides the choice of thing dictated by `focus-mode-to-thing' if set.")

(defvar-local focus-buffer nil
  "Local reference to the buffer focus functions operate on.")

(defvar-local focus-pre-overlay nil
  "The overlay that dims the text prior to the current-point.")

(dimmer-dim-buffer (current-buffer) 0.6)
(dimmer-restore-buffer (current-buffer))

(provide 'limelight)

;;; limelight.el ends here
