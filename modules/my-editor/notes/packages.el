;; -*- no-byte-compile: t; -*-
;;; editor/myorg/packages.el

;;; Org
(package! org-journal)
(package! org-pdftools)
(package! org-noter-pdftools)
(package! org-sidebar)
(package! org-noter)
(package! org-marginalia :recipe (:host github :repo "nobiot/org-marginalia"))
(package! org-transclusion :recipe (:host github :repo "nobiot/org-transclusion"))
(package! org-latex-impatient)

;; (package! org-roam-server)
;; (package! nroam :recipe (:host github :repo "NicolasPetton/nroam"))

;;; Markdown
(package! md-roam :recipe (:host github :repo "nobiot/md-roam"))
(package! poly-markdown)

;;; LaTeX
(package! bibtex-actions)

;;; Genérico
(package! calibredb)
