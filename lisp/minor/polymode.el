;;; lisp/minor/polymode.el -*- lexical-binding: t; -*-

(after! poly-markdown
  (defun poly-markdown-displayed-math-head-matcher (count)
    (when (re-search-forward "\\\\\\[\\|^[ \t]*\\(\\$\\$\\)." nil t count)
      (if (match-beginning 1)
          (cons (match-beginning 1) (match-end 1))
        (cons (match-beginning 0) (match-end 0)))))

  (defun poly-markdown-displayed-math-tail-matcher (_count)
    (if (match-beginning 1)
        ;; head matched an $$..$$ block
        (when (re-search-forward "[^$]\\(\\$\\$\\)[^$[:alnum:]]" nil t)
          (cons (match-beginning 1) (match-end 1)))
      ;; head matched an \[..\] block
      (when (re-search-forward "\\\\\\]" nil t)
        (cons (match-beginning 0) (match-end 0)))))

  (defun poly-markdown-inline-math-head-matcher (count)
    (when (re-search-forward "\\\\(\\|[ \t\n]\\(\\$\\)[^ $\t[:digit:]]" nil t count)
      (if (match-beginning 1)
          (cons (match-beginning 1) (match-end 1))
        (cons (match-beginning 0) (match-end 0)))))

  (defun poly-markdown-inline-math-tail-matcher (_count)
    (if (match-beginning 1)
        ;; head matched an $..$ block
        (when (re-search-forward "[^ $\\\t]\\(\\$\\)[^$[:alnum:]]" nil t)
          (cons (match-beginning 1) (match-end 1)))
      ;; head matched an \(..\) block
      (when (re-search-forward "\\\\)" nil t)
        (cons (match-beginning 0) (match-end 0)))))

  (define-innermode poly-markdown-inline-math-innermode poly-markdown-root-innermode
    "Inline math $..$ block.
                  First $ must be preceded by a white-space character and followed
                  by a non-whitespace/digit character. The closing $ must be
                  preceded by a non-whitespace and not followed by an alphanumeric
                  character."
    :mode 'latex-mode
    :head-matcher #'poly-markdown-inline-math-head-matcher
    :tail-matcher #'poly-markdown-inline-math-tail-matcher
    :head-mode 'latex-mode
    :tail-mode 'latex-mode
    :allow-nested nil)

  (add-hook! poly-markdown-mode
    (setq markdown-enable-math (not poly-markdown-mode))))
