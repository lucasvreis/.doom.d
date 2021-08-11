 ;;; -*- lexical-binding: t; -*-

(defun xenops-mode--should-enable-p ()
  (not (bound-and-true-p polymode-mode)))

(use-package xenops
  :commands xenops-mode
  :config
  ;; (require 'aio)
  ;; (require 'avy)
  ;; (require 'dash)
  ;; (require 'f)
  ;; (require 's)

  ;; (add-to-list 'xenops-elements
  ;;              '(block-math
  ;;                ((:delimiters . (("^[ \t]*\\\\begin{\\(align\\|equation\\|tikzpicture\\|gather\\|tikzcd\\)\\*?}"
  ;;                                  "^[ \t]*\\\\end{\\(align\\|equation\\|tikzpicture\\|gather\\|tikzcd\\)\\*?}")
  ;;                                 ("^[ \t]*\\\\\\["
  ;;                                  "^[ \t]*\\\\\\]")))
  ;;                 (:parser . xenops-math-parse-block-element-at-point)
  ;;                 (:handlers . (xenops-math-render
  ;;                               xenops-math-regenerate
  ;;                               xenops-math-reveal
  ;;                               xenops-math-image-increase-size
  ;;                               xenops-math-image-decrease-size
  ;;                               xenops-element-copy
  ;;                               xenops-element-delete)))))

  (setq xenops-math-image-scale-factor 1.8))
        ;; xenops-font-family "NewComputerModern Sans"
        ;; xenops-reveal-on-entry nil
