prologues:=3;
beginfig(30)
defaultscale:=200;
u:=20;
xu:=u; % unité de taille de base, à faire varier pour la chasse
yu:=u; % unité de taille de base, à faire varier pour la chasse
ybaseline:=0; % ligne de base
ycapheight:=21u; % hauteur totale
xwidth = 25u;
xpen:=5u; % graisse x
ypen:=5u; % graisse y

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
x2:=x3:=x4:=xleftside;
y1:=y2:=ybaseline;
y4:=y5:=ycapheight;
y3:=y6:=ycenter;
cutdraw z1 -- z2 -- z4 -- z5;
cutdraw z3 -- z6;
endfig
end
