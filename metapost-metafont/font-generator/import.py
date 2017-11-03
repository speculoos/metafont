# /usr/bin/env python2

import fontforge
import glob
import sys

SVG_DIR = glob.glob('svg/clean/*.svg')
font = fontforge.open('tmp/empty.sfd')
line_chasse = ' width="'

for glyph in SVG_DIR:
    letter = glyph.split("/")[-1].replace(".svg", "")
    print(letter)

    svg_file = open(glyph, "r")
    for ligne in svg_file:
        if line_chasse in ligne:
            val_chasse = ligne.split('width="')[-1].split('"')[-2]
            # val_chasse = (float(val_chasse) / 2) / 1.075
            val_chasse = float(val_chasse ) * 1.736;
            print('la valeooour des de', val_chasse)
    svg_file.close()

    letter_char = font.createChar(int(letter))
    letter_char.width = float(val_chasse)
    letter_char.importOutlines(glyph)

font.generate('FINAL/metafranquin.sfd')
