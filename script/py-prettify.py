#!/usr/bin/env python3

import flatlatex, string

c = flatlatex.converter()
template = '  ("%s" . ?%s)\n'

with open('prettify-latex-autogen.el', 'w') as f:
    f.write("(defvar prettify-mode--latex-autogen-alist '(\n")

    # Letters with special fonts and their {sub,super}scripts
    for l in string.ascii_letters:
        for kw in ('mathbb', 'mathcal', 'mathbf'):
            f.write(template % (r"\\%s{%s}" % (kw, l), c.convert(r'\%s{%s}' % (kw, l))))

        for m in ('^', '_'):
            maybe = c.convert(f".{m}{l}")[1]
            if maybe not in (m, '['):
                f.write(template % (f"{m}{l}", maybe))

    # Numeric {sub,super}scripts
    for i in range(10):
        for m in ('^', '_'):
            f.write(template % (f"{m}{i}", c.convert(f".{m}{i}")[1]))

    f.write(r"))")
