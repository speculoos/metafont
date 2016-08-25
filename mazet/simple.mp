prologues:=3;
u:=12pt;

% Variables

def mvariables=

xu:=u; % unité de taille de base, à faire varier pour la chasse
yu:=u; % unité de taille de base, à faire varier pour la chasse
ybaseline:=0yu; % ligne de base
ycapheight:=21yu; % hauteur totale
xpen:=4xu; % graisse x
ypen:=4yu; % graisse y

yleg:=ybaseline+ypen/2; % ligne de base du tracé horizontal
yarm:=ycapheight-ypen/2; % hauteur du tracé haut horizontal
ybaselineround:=yleg-ypen/4; % ligne de base avec débordement
ycapheightround:=yarm+ypen/4; % hauteur du tracé avec débordement
ybaselinegouache:=ybaseline-ypen/2; % dépassement en-dessous mbaseline pour gouache
ycapheighgouache:=ycapheight+ypen/2; % dépassement au-dessus mcapheight pour gouache

xleftside:=0; % bord gauche
xrightside:=xwidth; % bord droit
xleftstem:=xleftside+xpen; % bord gauche du tracé vertical
xrightstem:=xrightside-xpen; % bord droit du tracé vertical
xleftround:=xleftstem-xpen/2; % bord gauche du tracé rond
xrightround:=xrightstem+xpen/2; % bord droit du tracé rond
xend:=xpen/3; % valeur de largeur d'embouts
xendoblique:=xpen/3; % aleur de largeur d'embouts obliques

xcenter:=xwidth/2; % ligne centre x
ycenter:=ycapheight/2; % ligne centre y
yupbar:=ycenter+ypen; % tracé centre x compensé haut
ylowbar:=ycenter-ypen/2; % tracé centre x compensé bas
xbigbowl:=xrightround-xpen/4; % ligne centre x de l'arrondi grand
xsmallbowl:=xrightround-xpen/2; % ligne centre x de l'arrondi petit
yupbowl:=ycapheight-((ycapheight-ylowbar)/2); % ligne centre y de l'arrondi haut
ylowbowl:=ybaseline+(ybar/2); % ligne centre y de l'arrondi bas
xbowlattach:=xcenter; % le point d'attache de l'horizontale tangente au bowl
xbridge:=xpen/1.5; % valeur d'écartement des pointes

xpivot:=5u; % ligne de pivotement de l'attraction x
ypivot:=ycenter; % ligne de pivotement de l'attraction y
xfuite:=2xwidth; % ligne d'attraction x
yfuite:=ycapheight/1.2; % ligne d'attraction y
% zpivot=whatever[xcenter,ycenter]; % point de pivot
% zfuitepoint=whatever[xfuite,yfuite] % point d'attraction
% zfuite=whatever[zpivot,zfuitepoint] % ligne (axe) d'attraction entre point d'attraction et pivot

mcurve:=0.85; % courbes
mcurl:=0; % fin des courbes
mtension:=.9; % tension des pseudo droites

pickup pencircle yscaled xpen xscaled ypen;
linejoin:=mitered;

enddef;

def mcolor= % gris de la lettre
  withcolor .6white
enddef;

def mgrille(suffix mpoints)= % grille
pickup pencircle scaled 0.2;
for i=0 upto xwidth/u: % grille verticale
  draw (xleftside+i*u,ycapheight) -- (xleftside+i*u,ybaseline) withcolor .8white;
endfor
for i=0 upto ycapheight/u: % grille horizontale
  draw (xleftside,i*u) -- (xrightside,i*u) withcolor .8white;
endfor;
for i=1 upto mpoints: % entrée manuelle du nombre de points glyphe par glyphe (à automatiser?)
  dotlabels.bot([i]);
endfor;
enddef;

% Lettre E
beginfig(30)
xwidth:=15u;
mvariables;
x1=x5=x6=xrightside-xend;
x2=x3=x4=xleftstem;
y1=y2=yleg;
y4=y5=yarm;
y3=y6=ycenter;
cutdraw z1 -- z2 -- z4 -- z5 mcolor;
cutdraw z3 -- z6 mcolor;
mgrille(6);
endfig;

% Lettre A
beginfig(31)
xwidth:=18u;
mvariables;
x1=xleftside+xendoblique;
x4=xrightside-xendoblique;
x2=xcenter-xbridge/2;
x3=xcenter+xbridge/2;
y1=y4=ybaselinegouache;
y2=y3=yarm;
y5=y6=ylowbar-ypen/2;
z5=whatever[z1,z2];
z6=whatever[z3,z4];
cutdraw z1 -- z2 -- z3 -- z4 mcolor;
cutdraw z5 -- z6 mcolor;
mgrille(6);
endfig;

% Lettre O
beginfig(32)
xwidth:=15u;
mvariables;
x1=x3=xcenter;
x2=xleftround;
x4=xrightround;
y1=ybaselineround;
y2=y4=ycenter;
y3=ycapheightround;
cutdraw z1 .. z2 .. z3 .. z4 .. cycle mcolor;
mgrille(4);
endfig;

% Lettre R, reste à relier fuite, pivot, et tension dans une seule variable
beginfig(33)
xwidth:=15u;
mvariables;
x1=x2=x6=x10=xleftstem;
x3=x5=xbowlattach;
x4=xbigbowl;
x7=xbigbowl+xpen/4;
y1=ybaseline;
y7=ybaselinegouache;
y2=y3=yarm;
y8=yfuite;
y9=ylowbar;
x9=xpivot+1u; 
x8=x11=xfuite;
y10=y2-((y2-y6)/2);
y11=ycapheight-((ycapheight-yfuite)/2);
z6=whatever[z9,z8];
z5=whatever[z9,z8];
z5=whatever[xbowlattach];
z4=whatever[z11,z10];
cutdraw z1 -- z2 -- z3{dir(angle(z3-z2))} ..tension (mcurve).. z4 ..tension (mcurve).. {dir(angle(z9-z8))}z5 -- z6 mcolor;
cutdraw z5 -- z7 mcolor;
mgrille(11);
endfig;

end
