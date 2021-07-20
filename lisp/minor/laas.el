;;; lisp/minor/laas.el -*- lexical-binding: t; -*-

(aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "/" nil
                    "supp" "\\supp"
                    "cal" (cmd!
                            (yas-expand-snippet "\\mathcal{$1}$0"))
                    ;; bind to functions!
                    "sum" (cmd!
                            (yas-expand-snippet (concat "\\sum${1:$(when (> (length yas-text) 0) \"_\")"
                                                        "}${1:$(when (> (length yas-text) 1) \"{\")"
                                                        "}${1:i=0}${1:$(when (> (length yas-text) 1) \"}\")"
                                                        "}${2:$(when (> (length yas-text) 0) \"^\")"
                                                        "}${2:$(when (> (length yas-text) 1) \"{\")"
                                                        "}${2:n}${2:$(when (> (length yas-text) 1) \"}\")} $0")))
                    "int" (cmd!
                            (yas-expand-snippet (concat "\\int${1:$(when (> (length yas-text) 0) \"_\")"
                                                        "}${1:$(when (> (length yas-text) 1) \"{\")"
                                                        "}${1:a}${1:$(when (> (length yas-text) 1) \"}\")"
                                                        "}${2:$(when (> (length yas-text) 0) \"^\")"
                                                        "}${2:$(when (> (length yas-text) 1) \"{\")"
                                                        "}${2:b}${2:$(when (> (length yas-text) 1) \"}\")} $0")))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0")))
