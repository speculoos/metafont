# /usr/bin/env python

# Script pour attribuer un id aux strokes et au gouaches.

import glob

dir_svg = glob.glob('svg/*.svg')

stroke = 'style="stroke:rgb(0.000000%,0.000000%,0.000000%)';
chasse = 'style="stroke:rgb(100.000000%,0.000000%,0.000000%)';
gouache = 'style="fill: rgb(100.000000%,100.000000%,100.000000%)';

for svg_file in dir_svg:
    compt_gouache = 1
    compt_stroke = 1
    total = []
    name_char = svg_file.split("/")[-1].replace(".svg", "")
    svg_file = open('svg/' + name_char + '.svg', "r")
    for ligne in svg_file:
        if gouache in ligne:
            total.append(ligne.replace(gouache,  ' id="gouache' + str(compt_gouache) + '" ' + gouache))
            compt_gouache += 1
        elif stroke in ligne:
            total.append(ligne.replace(stroke,  ' id="stroke' + str(compt_stroke) + '" ' + stroke))
            compt_stroke += 1
        elif chasse in ligne:
            print('chasse')
        else:
            total.append(ligne)
    svg_file.close()

    name_char = name_char.replace("metafranquin-", "")

    write_file = open('svg/clean/'+name_char+'.svg', "w+")
    for write_line in total:
        write_file.write(write_line)
    write_file.close()

    print(name_char + ' -> ok ')

