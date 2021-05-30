;;; lisp/minor/writeroom-mode.el -*- lexical-binding: t; -*-

(setq +zen-text-scale 0.8
      writeroom-width fill-column)

(add-hook! writeroom-mode
  (+fill-column/toggle -1))

(advice-add 'set-fill-column :after (lambda (col) (setq writeroom-width col)))
