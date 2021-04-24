;;; lisp/julia.el -*- lexical-binding: t; -*-
(setq lsp-enable-folding t)
(setq lsp-julia-package-dir nil)
(setq lsp-julia-default-environment "~/.julia/environments/v1.6")
(setq lsp-julia-flags `("-J/home/lucas/.lib/julia/languageserver.so"))
