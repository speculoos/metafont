prologues:=3;

def mcolor= % gris de la lettre
  withcolor .5white
enddef;

beginfig(30)
defaultscale:=200;
u:=20;
xu:=u; % unité de taille de base, à faire varier pour la chasse
yu:=u; % unité de taille de base, à faire varier pour la chasse
ybaseline:=0; % ligne de base
ycapheight:=21u; % hauteur totale
xwidth = 21u;
xpen:=3u; % graisse x
ypen:=3u; % graisse y

yleg:=ybaseline+ypen/2; % ligne de base du tracé horizontal
yarm:=ycapheight-ypen/2; % hauteur du tracé haut horizontal
ybaselineround:=yleg-ypen/2; % ligne de base avec débordement
ycapheightround:=yarm+ypen/2; % hauteur du tracé avec débordement
ybaselinegouache:=ybaseline-ypen/2; % dépassement en-dessous mbaseline pour être gouaché
ycapheighgouache:=ycapheight+ypen/2; % dépassement au-dessus mcapheight pour être gouaché

xleftside:=0; % bord gauche
xrightside:=xwidth; % bord droit
xleftstem:=xleftside+xpen; % bord gauche du tracé vertical
xrightstem:=xrightside-xpen; % bord droit du tracé vertical
xleftround:=xleftstem-xpen; % bord gauche du tracé rond
xrightround:=mrightstem+xpen; % bord droit du tracé rond

xcenter:=xwidth/2; % ligne centre x
ycenter:=ycapheight/2; % ligne centre y
yupbar:=ycenter+ypen; % tracé centre x compensé haut
ylowbar:=ycenter-ypen; % tracé centre x compensé bas
xupbowl:=xrightround-xpen/2; % ligne centre y de l'arrondi haut
xlowbowl:=xrightround; % ligne centre y de l'arrondi bas
yupbowl:=ycapheight-((ycapheight-ybar)/2); % ligne centre x de l'arrondi haut
ylowbowl:=ybaseline+(ybar/2); % ligne centre x de l'arrondi bas
pickup pencircle yscaled xpen xscaled ypen;
linejoin:=mitered;
x1:=x5:=x6:=xrightside;
x2:=x3:=x4:=xleftstem;
y1:=y2:=yleg;
y4:=y5:=yarm;
y3:=y6:=ycenter;
cutdraw z1 -- z2 -- z4 -- z5 mcolor;
cutdraw z3 -- z6 mcolor;
pickup pencircle scaled 1;
for i=0 upto xwidth/u: % grille verticale
  draw (xleftside+i*u,ycapheight) -- (xleftside+i*u,ybaseline) withcolor red;
endfor
for i=0 upto ycapheight/u: % grille horizontale
  draw (xleftside,i*u) -- (xrightside,i*u) withcolor red;
endfor;
defaultscale :=4; % agit sur la taille des labels de points
for i=1 upto 6: % entrée manuelle du nombre de points glyphe par glyphe (à automatiser?)
  dotlabels.top([i]);
endfor;
endfig
end
