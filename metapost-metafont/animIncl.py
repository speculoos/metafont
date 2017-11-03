#! /usr/bin/env python
# -*- coding: utf-8 -*-

import fontforge

font = 'FINAL/POE.sfd'

for gly in fontforge.open(font).glyphs():
        #gly.
        gly.export(gly.glyphname + ".png", 1000)
        print('bien')
