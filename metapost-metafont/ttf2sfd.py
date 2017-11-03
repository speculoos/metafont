#! /usr/bin/env python
# -*- coding: utf-8 -*-

import fontforge
import glob
#import sys

#fontname = sys.argv[1]

font = fontforge.open('temp/font.ttf')
font.generate('temp/font.sfd')
