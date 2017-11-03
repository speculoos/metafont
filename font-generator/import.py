# /usr/bin/env python2

import fontforge
import glob
import sys

SVG_DIR = glob.glob('svg/clean/*.svg')
font = fontforge.open('tmp/empty.sfd')

for glyph in SVG_DIR:
    letter = glyph.split("/")[-1].replace(".svg", "")
    print(letter)
    letter_char= font.createChar(int(letter))
    letter_char.width = 611
    letter_char.importOutlines(glyph)

font.generate('FINAL/metafranquin.sfd')
