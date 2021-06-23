;;; defcustoms.el --- File to put customizable variables  -*- lexical-binding: t; -*-

(defcustom treemacs-file-ignore-extensions
  '("aux" "ptc" "fdb_latexmk" "fls" "synctex.gz" "toc"         ;; LaTeX
    "glg"  "glo"  "gls"  "glsdefs"  "ist"  "acn"  "acr"  "alg" ;; LaTeX - glossary
    "mw"                                                       ;; LaTeX - pgfplots
    "pdfa.xmpi")                                               ;; LaTeX - pdfx
  "File extension which `treemacs-ignore-filter' will ensure are ignored"
  :safe #'string-list-p)

(defcustom treemacs-file-ignore-globs
  '("*/_minted-*"                                        ;; LaTeX
     "*/.auctex-auto" "*/_region_.log" "*/_region_.tex") ;; AucTeX
  "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored"
  :safe #'string-list-p)
