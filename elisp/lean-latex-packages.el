;;; XeLaTeX customisations
;; remove "inputenc" from default packages as it clashes with xelatex
;; (setf org-latex-default-packages-alist
;;       (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))

(setq org-latex-default-packages-alist
      '(("T1" "fontenc" t)
        ("" "fixltx2e" nil)
        ("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)
        ("" "wrapfig" nil)
        ("" "rotating" nil)
        ("normalem" "ulem" t)
        ("" "amsmath" t)
        ("" "amsfonts" t)
        ("" "bussproofs" t)
        ("" "mylogic" t)
        ("" "textcomp" t)
        ("" "marvosym" t)
        ("" "wasysym" t)
        ("" "amssymb" t)
        ("" "imakeidx" nil)
        ("" "hyperref" nil)
        "\\tolerance=1000"))
(provide 'lean-latex-packages)
