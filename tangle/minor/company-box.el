;;; tangle/minor/company-box.el -*- lexical-binding: t; -*-
(defadvice! my/company-box-ensure-window-exists (&rest _)
  :before #'company-box--move-selection
  (unless (get-buffer-window (company-box--get-buffer) t)
    (company-box--set-frame (company-box--get-frame)))) ; or company-box--make-frame ?
