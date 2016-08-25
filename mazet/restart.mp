prologues:=3; % ps output (remove the % if needed)

% Échelle
u:=100pt; % taille globale (agissant en parallèle de defaultscale sur les labels de points lisibles)
defaultscale:=.2;

% Variables lettrage au Mazet
def mvariables=
xu:=u; % unité de taille de base, à faire varier pour la chasse
yu:=u; % unité de taille de base, à faire varier pour la chasse
ybaseline:=0; % ligne de base
ycapheight:=21u; % hauteur totale
% mwidth = chasse en u, définie comme variable au début de chaque fig (glyphe)
xpen:=3u; % graisse x
ypen:=3u; % graisse y

yleg:=ybaseline+ypen/2; % ligne de base du tracé horizontal
yarm:=ycapheight-ypen/2; % hauteur du tracé haut horizontal
ybaselineround:=yleg-ypen/2; % ligne de base avec débordement
ycapheightround:=yarm+ypen/2; % hauteur du tracé avec débordement
ybaselinegouache:=ybaseline-ypen/2 % dépassement en-dessous mbaseline pour être gouaché
ycapheighgouache:=ycapheight+ypen/2 % dépassement au-dessus mcapheight pour être gouaché

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

% xpivot:=xcenter; % ligne de pivotement de l'attraction x
% ypivot:=ycenter; % ligne de pivotement de l'attraction y
zpivot:=whatever[xcenter,ycenter]; % point de pivot
% xfuite:=2xwidth; % ligne d'attraction x
% yfuite:=ycapheight; % ligne d'attraction y
zfuitepoint:=whatever[2xwidth,ycapheight] % point d'attraction
zfuite:=whatever[zpivot,zfuitepoint] % ligne (axe) d'attraction entre point d'attraction et pivot
enddef;

mcurve:=.84; % courbes
mfleche:=0; % courbes
mtension:=.9; % tension

mvisual:=2; % 0 = sans grille , 1 = avec marges , 2 = avec marge + grille + numéros des points
mmarg:=0; % marge en x

% Glyphe début
def spchar(expr carac)=
  beginfig(carac)
  mvariables; % injection de toutes les variables de lettrage
enddef;

% Grille et glyphe fin
def col= % gris de la lettre
    if visual>1:
         withcolor .5white
    else:
    fi
enddef;

def spcharend(suffix mpoints)=
pickup pencircle scaled 1;

if visual>=1: % rectangle de bord
    draw (-mmarg*u,-2*u)--((mmarg+widthx)*u,-2*u)--((mmarg+widthx)*u,ycapheight+u)--(-mmarg*u,ycapheight+u)-- cycle withcolor blue;
    fi
    if mvisual>1:  
    pickup pencircle scaled 1
      for i=0 upto xwidth: % grille verticale
        draw (i*u,ycapheight)--(i*u,0) withcolor red;
      endfor
      for i=0 upto ycapheight/u: % grille horizontale
        draw (0,i*u)--(xwidth*u,i*u) withcolor red;
      endfor;
    defaultscale :=4; % agit sur la taille des labels de points
    for i=1 upto mpoints: % entrée manuelle du nombre de points glyphe par glyphe (à automatiser?)
        dotlabels.top([i]);
    endfor;
fi
endfig
enddef;

% ## Pen
pickup pencircle xscaled xpen yscaled ypen;
linejoin:=mitered;

% ## Droitues
% Lettre E
mwidth:=6;
spchar(1)
x4:=x1:=RightCorner;
y1:=y2:=bo;
x5:=x3:=x2:=LeftCorner;
y4:=y3:=mcapheight;
y6:=y5:=MeanLine + .25ux;
x6:=RightCorner- 0.5ux;
cutdraw z1 -- z2 -- z3 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% ## Pentues
% Lettre A
mwidth:=7;
spchar(2)
x1=LeftCorner - .5ux; 
y1=mbaseline;
x2=Middle - Bridge; 
y3=y2=mcapheight;
x3=Middle;
%y5=y4=MeanLine - 1.75ux;
x5=.3[x1,x2];
y4=y5=.3[y1,y2];
x4=0.3[x1,x2]+(Middle-x5)*2;
%x5=2cx;
path dleft,dright;
dleft=z1...{crb(1,2,tens)}z2--z3;
dright=dleft reflectedabout(A,B);
cutdraw dleft col;
cutdraw dright col;
cutdraw z4--z5 col;
gouache(1, 154, refl);
gouache(3, 0, sup);
spcharend(5);

% ## Rondues
% Lettre R
mwidth:=6;
spchar(3)
MeanLine:=mcapheight/3; % a faire varier
mbaseline:=0;
LeftFoot:=-2cx;% a faire varier
RightFoot:=2cx;% a faire varier
Middle:=0cx;% a faire varier
VanishPoint:=RightFoot*2;% a faire varier
Pivot:=(Middle-LeftFoot)/2;
x1:=x2:=x6:=x10:=LeftFoot;
y3:=y2:=mcapheight;
y1:=y7:=mbaseline;
x3:=x5:=Middle;
y8:=mcapheight/1.5; % a faire varier entre MeanLine et mcapheight ou mcapheight avec un diviseur
x8:=x11:=VanishPoint/2;
y9:=MeanLine;
x9:=Pivot;
z6:=whatever [z9,z8];
z5=whatever [z9,z8];
z5=whatever [Middle];
y10:=y2-((y2-y6)/2);
x4:=x7:=RightFoot;
y11:=mcapheight-((mcapheight-y8)/2);
z4:=whatever [z11,z10];
cutdraw z1 -- z2 .. z3{dir(angle(z3-z2))} ..tension 1.2.. z4 ..tension 1.2.. {dir(angle(z9-z8))}z5 .. z6 col;
cutdraw z5--z7 col;
spcharend(6);

% Lettre O
mwidth:=6;
spchar(4)
x1:=x3:=Middle;
x2:=LeftFoot;
x4:=RightFoot;
y1:=mbaseline;
y3:=mcapheight;
y2:=y4:=MeanLine;
cutdraw z1 .. z2 .. z3 .. z4 .. cycle col;
spcharend(6);

% Lettre 0 version 2
mwidth:=6;
spchar(5)
z8:=(0,3u); 
z9:=(mwidth,18u);
mfuite:=[z8,z9];
x1:=x3:=mmiddlex;
y1:=mbaselineround;
y3:=mcapheightround;
z2:=whatever [letfsideround,mfuite]; %(3u,6u);
z4:=whatever [mrightsideround,mfuite]; %(15u,15u);%;
cutdraw mfuite; %(0,3u)--(mwidth,18u);
cutdraw z1{dir(angle(z2-z4))} .. {dir(angle(90))}z2{dir(angle(90))} .. {dir(angle(z4-z2))}z3{dir(angle(z4-z2))} .. {dir(angle(-90))}z4{dir(angle(-90))} .. {dir(angle(z2-z4))}cycle col;
spcharend(4);

% ## Flexues

end
