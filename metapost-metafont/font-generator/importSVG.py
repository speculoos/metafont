# /usr/bin/env python2

import fontforge
import glob
import sys

SVG_DIR = glob.glob('svg/clean/*.svg')
font = fontforge.open('tmp/empty.sfd')

for glyph in SVG_DIR:
    print(glyph)
    svg_file = open(glyph, "r")
    for ligne in svg_file:
        print(ligne)
    # for ligne in svg_file:
    #     if line_chasse in ligne:
    #         val_chasse = ligne.split('width="')[-1].split('" height="')[-2]
    #         val_chasse = (float(val_chasse) / 2) / 1.075
    #         # print('la valeur des de', val_chasse)
    # svg_file.close()

#     letter = glyph.split("/")[-1].replace(".svg", "")
#     letter_char= font.createMappedChar(letter)
#     letter_char.width = 600
#     letter_char.importOutlines(glyph)
#
#
# font.fontname = 'ume-stroke-stroke'
# font.familyname = 'ume-stroke-stroke'
# font.generate('FINAL/ume.sfd')
