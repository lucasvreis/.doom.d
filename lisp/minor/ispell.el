;;; lisp/minor/ispell.el -*- lexical-binding: t; -*-

(setq ispell-dictionary "pt_BR,en_US"
      ispell-personal-dictionary (concat doom-private-dir ".hunspell-personal"))
(ispell-set-spellchecker-params)
(ispell-hunspell-add-multi-dic "pt_BR,en_US")

(unless (file-exists-p ispell-personal-dictionary)
  (write-region "" nil ispell-personal-dictionary nil 0))
