;;; lisp/minor/selectrum.el -*- lexical-binding: t; -*-

(map! :map 'selectrum-minibuffer-map
         "C-k" 'next-line
         "C-l" 'previous-line)
