;;; my-checkers/languagetool/config.el -*- lexical-binding: t; -*-

(use-package lsp-ltex
  :defer t
  :init
  (setq lsp-ltex-version "12.3.0"
        lsp-ltex-active-modes '(text-mode latex-mode org-mode markdown-mode))

  (add-hook! org-indent-mode
    (setq flycheck-indication-mode (if org-indent-mode nil 'left-fringe)))

  (add-hook! flyspell-mode
    (when (apply #'derived-mode-p lsp-ltex-active-modes)
      (if flyspell-mode
          (progn
            (require 'lsp-ltex)
            (setq lsp-ltex-enabled t)
            (lsp-deferred))
        (setq lsp-ltex-enabled nil))))

  :config
  (add-to-list 'lsp-language-id-configuration '(org-mode . "org"))

  (setq lsp-ltex-enabled nil
        lsp-ltex-enabled-rules (json-parse-string "{\"pt-BR\": [\"POR_QUE_PORQUE\"]}")
        lsp-ltex-disabled-rules (json-parse-string "{\"pt-BR\": [\"HUNSPELL_RULE\"]}")
        lsp-ltex-additional-rules-word-2-vec-model "/usr/share/word2vec"
        lsp-ltex-dictionary (json-parse-string "{\"pt-BR\": [\"Dummy\"]}")
        lsp-ltex-language "pt-BR"
        lsp-ltex-mother-tongue "pt-BR"
        lsp-ltex-check-frequency "save"
        lsp-ltex-latex-commands (json-parse-string "{\"\\\\cite{}\": \"dummy\"}")))
