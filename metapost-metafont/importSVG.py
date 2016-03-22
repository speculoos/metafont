# /usr/bin/env python
# -*- coding: utf-8 -*-

import fontforge
import glob
#import sys

font = fontforge.open('temp/font.sfd')
svg_final = glob.glob('svg/*svg')

for letter_svg in svg_final:
    letter = letter_svg.split("/")[-1].replace(".svg", "")
    print(letter)
    glyph = font.createMappedChar(letter)
    glyph.importOutlines(letter_svg)

font.generate('FINAL/Final.otf')
