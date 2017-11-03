# /usr/bin/env python

svg_file = open('M.svg', "r")
stroke = 'id="white"';
gouache = 'style="fill: rgb(100.000000%,100.000000%,100.000000%)';

total = []

compt_gouache = 1
for ligne in svg_file:
    if gouache in ligne:
       total.append(ligne.replace('style="fill: rgb(100.000000%,100.000000%,100.000000%)',  ' id="gouache' + str(compt_gouache) + '" style="fill: rgb(100.000000%,100.000000%,100.000000%)'))
       compt_gouache += 1

    else:
        total.append(ligne)
svg_file.close()

write_file = open('M-test.svg', "a+")
for write_line in total:
    write_file.write(write_line)
write_file.close()

