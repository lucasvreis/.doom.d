;;; lisp/look/look.el -*- lexical-binding: t; -*-

;; Deixa a seleção menos distrativa
(defvar custom-themes-exclude
  '(doom-acario-light
    doom-acario-dark
    doom-badger
    doom-dark+
    doom-henna
    doom-homage-white
    doom-Iosvkem
    doom-1337
    doom-molokai
    doom-sourcerer
    doom-peacock
    doom-wilmersdorf
    doom-manegarm
    doom-ephemeral
    doom-nova
    doom-opera
    doom-zenburn
    doom-ayu-mirage
    doom-vibrant
    doom-ir-black
    doom-old-hope
    doom-miramare
    doom-monokai-spectrum
    doom-monokai-ristretto))

(advice-add 'custom-available-themes :filter-return
            (lambda (l)
              (seq-difference
               (seq-filter (lambda (x) (s-prefix? "doom-" (symbol-name x))) l)
               custom-themes-exclude #'eq)))
