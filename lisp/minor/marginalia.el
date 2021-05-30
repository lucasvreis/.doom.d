;;; lisp/minor/marginalia.el -*- lexical-binding: t; -*-

;; DISCLAIMER: code below was taken and mixed from all-the-icons-ivy.el and a marginalia's github issue.

(add-hook! marginalia-mode
  (advice-add #'completion-metadata-get :around #'icon-completion-metadata-get))

(defface all-the-icons-dir-face
  '((((background dark))  :foreground "white")
    (((background light)) :foreground "black"))
  "Face for the dir icons used in ivy"
  :group 'all-the-icons-faces)

(defun all-the-icons-selectrum-icon-for-file (s)
  "Return icon for filename S.
Return the octicon for directory if S is a directory.
Otherwise fallback to calling `all-the-icons-icon-for-file'."
  (cond
   ((string-match-p "\\/$" s)
    (all-the-icons-octicon "file-directory" :face 'all-the-icons-dir-face))
   (t (all-the-icons-icon-for-file s))))

(defun icon-get (cand cat)
    "Return the icon for the candidate CAND of completion category CAT."
    (cl-case cat
      (file (concat (all-the-icons-selectrum-icon-for-file cand) " "))
      (buffer
       (let* ((mode (buffer-local-value 'major-mode (get-buffer cand)))
              (icon (all-the-icons-icon-for-mode mode))
              (parent-icon (all-the-icons-icon-for-mode
                            (get mode 'derived-mode-parent))))
         (concat
          (if (symbolp icon)
              (if (symbolp parent-icon)
                  (all-the-icons-faicon "sticky-note-o")
                parent-icon)
            icon)
          " ")))))

(defun icon-completion-metadata-get (orig metadata prop)
  "Advice for `completion-metadata-get' which adds icons as prefix."
  (if (eq prop 'affixation-function)
      (let ((cat (funcall orig metadata 'category))
            (aff (funcall orig metadata 'affixation-function)))
        (cond
         ((and (eq cat 'consult-multi) aff)
          (lambda (cands)
            (mapcar (lambda (x)
                      (pcase-exhaustive x
                        (`(,cand ,suffix)
                         (list cand (icon-get
                                     (substring cand 0 -1)
                                     (car (get-text-property 0 'consult-multi cand)))
                               suffix))
                        (`(,cand ,_ ,suffix)
                         (list cand (icon-get
                                     (substring cand 0 -1)
                                     (car (get-text-property 0 'consult-multi cand)))
                               suffix))))
                    (funcall aff cands))))
         ((and cat aff)
          (lambda (cands)
            (mapcar (lambda (x)
                      (pcase-exhaustive x
                        (`(,cand ,suffix)
                         (list cand (icon-get cand cat) suffix))
                        (`(,cand ,_ ,suffix)
                         (list cand (icon-get cand cat) suffix))))
                    (funcall aff cands))))
         ((eq cat 'consult-multi)
          (lambda (cands)
            (mapcar (lambda (x)
                      (list x (icon-get
                               (substring x 0 -1)
                               (car (get-text-property 0 'consult-multi x))) ""))
                    cands)))
         (cat
          (lambda (cands)
            (mapcar (lambda (x)
                      (list x (icon-get x cat) ""))
                    cands)))
         (aff)))
      (funcall orig metadata prop)))
