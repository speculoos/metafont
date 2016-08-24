% ## Documentation

% Franquin notes :
% https://github.com/speculoos/metafont

% Guide
% http://tex.loria.fr/prod-graph/zoonekynd/metapost/metapost.html

% Some pdfs :
% http://antoine-gelgon.fr/MetaPost-Doc/
% http://tex.stackexchange.com/questions/107489/what-is-metapost-metafont-and-how-can-i-get-started-using-it

% Some simples examples to start :
% http://tex.loria.fr/prod-graph/zoonekynd/metapost/metapost.html
% http://www.ursoswald.ch/metapost/tutorial.html

% The Metadin repo:
% https://github.com/osp/osp.foundry.metadin

% Unicode
% https://en.wikipedia.org/wiki/List_of_Unicode_characters#Basic_Latin
% Partly translated in german - unicode tabelle auf deutsch : http://unicode-table.com/de

% Anatomie http://caracteres.typographie.org/description/anatomie.html


% ## Shell commands

% To get the .mp in local:
% curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && mpost metafranquin.mp

% And in loop:
% for (( ; ; )); do curl http://pads.osp.kitchen/p/metadin/export/txt > metafranquin.mp && mpost metafranquin.mp ; sleep 10; done

% And without stopping on error and doing screenshots!
% for (( ; ; )); do import -window root screen/$(date +%m-%d-%h-%m-%s).png sleep 100; done
% for (( ; ; )); do import -window root screen/$(date +%s).png; sleep 100; done
% And without stopping on error and doing screenshots!

% for (( ; ; )); do curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && curl http://pads.osp.kitchen/p/metafranquinparam/export/txt > metafranquinparam.mp && mpost -interaction=batchmode -s ' outputformat="svg" '  metafranquin.mp; sleep 10; done

% LETTER=A && mpost -interaction=batchmode  -s ' outputformat="svg" '  UC/$LETTER.mp && inkscape $LETTER*.svg


% ## Fonctions et grille

prologues:=3; % ps output (remove the % if needed)

% le pad des params et des def : http://pads.osp.kitchen/p/metafranquinparam
% input metafranquinparam

% in mazet offline local version
% $ for (( ; ; )); do mpost -interaction=batchmode -s ' outputformat="svg" '  metafranquin-mazet.mp; sleep 10; done


% ## Paramètres

% outputtemplate := "%j%c.svg"; % exporter en svg.
% Mot:='82 78 80';

% Unité
u:=100pt; % taille globale (agissant en parallèle de defaultscale sur les labels de points lisibles)
mux:=u; % à faire varier pour la chasse
muy:=u;

% Variables lettrage au Mazet
def mvariables=
% mwidth = chasse en u, définie comme variable au début de chaque fig (glyphe)
mpenx:=3u; % graisse x
mpeny:=3u; % graisse y
mpenxy=mpenx+mpeny/2; % moyenne xy
mroundoverx=mpenx/2; % débordement pour arrondis x
mroundovery=mpeny/4; % débordement pour arrondis y
mbaseline:=0; % ligne de base
mbaselinepen:=mbaseline+(mpeny/2); % ligne de base du tracé
mbaselineround:=mbaselinepen-mroundovery; % ligne de base avec débordement
% mbaselinegouache = dépassement en-dessous mbaseline pour être gouaché
mcapheight:=21u; % hauteur totale
mcapheightpen:=mcapheight-(mpeny/2); % hauteur du tracé
mcapheightround:=mcapheightpen+mroundovery; % hauteur du tracé avec débordement
% capheighgouache = dépassement au-dessus mcapheight pour être gouaché
mleftside:=0; % bord gauche
mleftsidevertical:=mleftside+1.5mpenx; % bord gauche du tracé vertical
mleftsideround:=mleftsidevertical-mroundoverx; % bord gauche du tracé rond
mrightside:=mwidth; % bord droit
mrightsidevertical:=mrightside-1.5mpenx; % bord droit du tracé vertical
mrightsideround:=mrightsidevertical+mroundoverx; % bord droit du tracé rond
mmiddley:=mcapheight/2; % ligne centre y
% mmiddlex = ligne centre x mais pris en charge par la chasse (mwidth) de chaque caractère
% mupperbowly = ligne centre y de l'arrondi haut
% mlowerbowly = ligne centre y de l'arrondi bas
mbridgex:=mmiddley; % tracé centre x compensé
mpivotx:=mbridgex; % ligne de pivotement de l'attraction x
mpivoty:=mwidth; % ligne de pivotement de l'attraction y
mpivot:=whatever[mpivotx,mpivoty]; % point de mpivot
mfuitex:=2mwidth; % ligne d'attraction x
mfuitey:=mcapheight; % ligne d'attraction y
mfuitepoint:=whatever[mfuitex,mfuitey] % point d'attraction
mfuite:=whatever[mpivot,mfuitepoint] % ligne (axe) d'attraction entre point d'attraction et mpivot

ux:=sasx:=mpenx; % ancien
uy:=sasy:=mpeny; % ancien
sas:=(sasx+sasy)/2; % ancien
bo:=mbaselinepen; % ancien
h:=mcapheight; % ancien
ho:=mcapheightpen; % ancien
barheight:=mmiddley; % ancien
enddef;

% Variations typographiques
% w width chasse
% b boldness graisse
% i incline inclinaison
% c contrast contraste
% p perspective perspective
% r roundness rondeur
% t tension tension
% m middle milieu (en y)
% o openess ouverture
% e ends embouts

val:=.84; % courbes
fleche:=0; % courbes
tens:=.9; % tension

visual:=2; % 0 = sans grille , 1 = avec marges , 2 = avec marge + grille + numéros des points
marg:=0; % marge en x

% Construction Darius
def buildarius=
Baseline:=0; % Ligne de base
CapHeight:=VanishPointMean:=ho; % Hauteur de la lettre
MeanLine:=h/2; % Milieu de la case
Middle:=0cx;
LowerBowl:=CapHeight/4; % Arrondis bas
Pivot:=Middle;
LeftCorner:=-2cx;
RightCorner:=2cx;
Bridge:=sasx/3; % Traverse de la lettre
enddef;

% Caractère
def spchar(expr carac)=
  beginfig(carac)
  mmiddlex:=(mwidth*mux)/2;
    def cx=
        10u+mmiddlex; % multiplicateur de u à définir
    enddef;
    def cy=
        1000; % multiplicateur de u à définir
    enddef;
    pair A,B; % centre vertical pour miroir
    A:=(mmiddlex,0u);
    B:=(mmiddlex,7u);
    pickup pencircle xscaled mpenx yscaled mpeny;
    linejoin:=mitered;
mvariables; % injection de toutes les variables de lettrage
% buildarius; % ancien
enddef;

% Tensions des droites pour les incurver
def crb(suffix i,j,val)=
    if x.i<x.j:
        if y.i<y.j:
            ((x.i-x.j)/(y.i-y.j))*(x.i+x.j)*val,x.j+x.i
        fi
        if y.i>y.j:
            ((x.i-x.j)/(y.i-y.j))*(x.i+x.j)*val,x.j+x.i
        fi
    fi
enddef;

% Grille
def col= % gris de la lettre
    if visual>1:
         withcolor .5white
    else:
    fi
enddef;

def spcharend(suffix n_points)=
pickup pencircle scaled 1;

if visual>=1: % rectangle de bord
    draw (-marg*u,-2*u)--((marg+mwidth)*u,-2*u)--((marg+mwidth)*u,h+u)--(-marg*u,h+u)-- cycle withcolor blue;
    fi
    if visual>1:  
    pickup pencircle scaled 1
      for i=0 upto mwidth: % grille verticale
        draw (i*u,mcapheight)--(i*u,0) withcolor red;
      endfor
      for i=0 upto mcapheight/u: % grille horizontale
        draw (0,i*u)--(mwidth*u,i*u) withcolor red;
      endfor;
    defaultscale :=4; % agit sur la taille des labels de points
    for i=1 upto n_points: % entrée manuelle du nombre de points glyphe par glyphe (à automatiser?)
        dotlabels.top([i]);
    endfor;
fi
endfig
enddef;

def PVisual(suffix visual,i,j,k)= % ancien
  if visual>1:
    withcolor .6white;
  fi
enddef;

% Courbes spirou % ancien
def spirou_soft(suffix i,j) =
  if x.i<x.j:
    cutdraw z.i{val.u,x.j-x.i}
    ... z.j
  fi
  if x.i>x.j:
    cutdraw z.i{val.u,x.i-x.j}
    ... z.j
  fi
enddef;

def spirou_half(suffix i,j,k) =
 inco:=0;
 cutdraw z.i{inco,y.j-y.i}
 ... (val[x.j,x.i],val[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,inco}
 ... (val[x.j,x.k],val[y.k,y.j]){z.k-z.j}
 ... z.k{inco,y.k-y.j}
    col
enddef;

def spirou_crescent(suffix i,j,k) =
 inco:=0;
 draw z.i{x.j-x.i,inco}
  ... (val[x.i,x.j],val[y.j,y.i]){z.j-z.i}
  ... z.j{inco,y.k-y.i}
  ... (val[x.k,x.j],val[y.j,y.k]){z.k-z.j}
  ... z.k{x.k-x.j,inco}
    col
enddef;

% Pen % ancien
def pen_form(expr type_pen) =
  pickup type_pen scaled sas;
enddef;

% Diagonale % ancien
def diago (suffix i,j,deg)=
    sasxdia=sasx-.8u;
    sasydia=sasy-.8u;
    pickup pensquare xscaled sasxdia yscaled sasydia rotated deg;
    cutdraw z.i--z.j col;
enddef;

def //(suffix i,j,orient) =
if orient=r
.. (.3[x.i,x.j]+.1ux, .3[y.i,y.j]) ..
elseif orient=left
.. (.3[x.i,x.j]-.1ux, .3[y.i,y.j]) ..
fi
enddef;

defaultscale:=.2;


% ## Types de lettres

% Droitues = E, F, H, I, L, T, 
% Pentues = A, K, M, N, V, W, X, Y, Z, 1, 4, 7
% Rondues = B, C, D, J, G, O, P, Q, R, U, 2, 3, 5, 6, 9, 0
% Flexues = S, 8


% ## Droitues

% Lettre E
mwidth:=6;
spchar(69)
x4:=x1:=RightCorner;
y1:=y2:=bo;
x5:=x3:=x2:=LeftCorner;
y4:=y3:=mcapheight;
y6:=y5:=MeanLine + .25ux;
x6:=RightCorner- 0.5ux;
cutdraw z1 -- z2 -- z3 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre F
mwidth:=6;
spchar(70)
x4:=x1:=RightCorner;
y1:=bo;
x5:=x3:=x2:=LeftCorner;
y2:=mbaseline;
y4:=y3:=mcapheight;
y6:=y5:=MeanLine + .25ux;
x6:=RightCorner- 0.5ux;
cutdraw z2 -- z3 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre H
mwidth:=6;
spchar(72)
x6:=x4:=x1:=RightCorner;
y2:=y1:=mbaseline;
x5:=x3:=x2:=LeftCorner;
y4:=y3:=h;
y6:=y5:=MeanLine - 1ux;
cutdraw z2 -- z3 col; 
cutdraw  z1 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre I
mwidth:=3;
spchar(73)
x2:=x1:=Middle;
y2:=h;
y3:=mbaseline;
cutdraw z1 -- z2 col; 
spcharend(6);

% Lettre L
mwidth:=5;
spchar(76)
x4:=x1:=RightCorner - .5ux;
y1:=bo;
x5:=x3:=x2:=LeftCorner;
y2:=bo;
y4:=y3:=h;
cutdraw z1 -- z2 -- z3  col;
spcharend(6);

% Lettre T
mwidth:=5;
spchar(84)
x2:=x1:=Middle;
y1:=mbaseline;
y3:=y4:=y2:=ho;
x3:=LeftCorner - .5ux;
x4:=RightCorner + .5ux;
cutdraw z1 -- z2 col; 
cutdraw z3 -- z4 col;
spcharend(4);


% Pentues

% Lettre A
mwidth:=7;
spchar(65)
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

% Lettre M
mwidth:=7;
spchar(77)
x2=x1=LeftCorner - .4ux; 
x3=x2 + Bridge;
x4=Middle;
x5=x6 - Bridge;
x7=x6=RightCorner + .4ux;
y7=y1=0;
y6=y5=y3=y2=ho;
y4=MeanLine - 1.30ux;
cutdraw z1--z2--z3--z4--z5--z6--z7 col;
gouache(2,0,sup);
gouache(6,0,sup);
gouache(1,0);
gouache(7,0);
spcharend(7);

% Lettre V
mwidth:=7;
spchar(86)
x1=LeftCorner - .5ux; 
y1=h;
x2=Middle - Bridge; 
y3=y2=bo;
x3=Middle;
path dleft,dright;
dleft=z1--z2--z3;
dright=dleft reflectedabout(A,B);
cutdraw dleft col;
cutdraw dright col;
spcharend(5);

% Anciens dessins

% Lettre D
mwidth:=6;
spchar(68)
x2=x1=-2cx; y5=y1=bo;
y3=y2=ho;
x5=x3=0cx;
x4=2.25cx; y4=barheight;
spirou_crescent(3,4,5);
cutdraw z5--z1--z2--z3 col;
spcharend(5);

% Lettre N
mwidth:=6;
spchar(78)
x2=x1=-2cx; y4=y5=y1=0cy;
x3=x2+0.1ux;
x4=x5-0.1ux;
y3=y6=y2=7cy;
x6=x5=2cx;
linejoin:=beveled;
cutdraw z1--z2 col;
cutdraw z5--z6 col;
diago(3,4,45);
gouache(1,0);
gouache(6,0);
gouache(2,8,doubl);
gouache(5,8,doubl);
spcharend(6);

% Lettre R
mwidth:=6;
spchar(82)
x6=x2=x1=-2cx; y1=0cy;
y3=y2=ho;
x5=x3=0cx; y6=y5=barheight-0.5cy;
x4=2.25cx; y4=y5+((ho-y5)/2);
x7=2.5cx; y7=.2cy;
spirou_crescent(3,4,5);
cutdraw z1--z2--z3 col;
cutdraw z5--z6 col;
cutdraw z5--z7 col;
gouache(1,0);
gouache(7,35);
spcharend(7);

% Lettre N
mwidth:=6;
spchar(78)
x2=x1=-2cx; 
x3=-1.75cx;
x4=1.75cx;
x5=x6=2cx;
y1=0;
y4=y5=bo;
y6=h;
y3=y2=ho;
y4=1.5cy;
cutdraw z1 //(1,2,r) z2 -- z3 //(3,4,r) z4 -- z5 //(5,6,left) z6 col;
%gouache(2,0,sup);
%gouache(6,0,sup);
%gouache(1,0);
%gouache(7,0);
spcharend(6);

% Lettre K
mwidth:=5;
spchar(75)
x2=x1=-1.5cx; y1=0cy;
y2=h;
y4=h-0.30cy;
x5=-0.75cx;
y5=barheight+0cy;
x4=2cx; y4=y5+((ho-y5)/2);
x7=2.25cx; y7=.2cy;
cutdraw z1--z2 col;
cutdraw z4--z5--z7 col;
%gouache(4,165);
%gouache(7,35);
spcharend(7);

% Lettre B
mwidth:=18;
spchar(66)
x6=x2=x1=-2.5cx; y8=y1=bo;
y3=y2=ho;
x8=x3=.8cx; y6=y5=barheight -0cy;
x5=0.5cx;
x4=2.25cx;
x7=2.40cx; 
y4=y5+((ho-y5)/2);
y7=(y5-y8)/2+bo;
spirou_crescent(3,4,5);
spirou_crescent(5,7,8);
cutdraw z8--z1--z2--z3 col;
cutdraw z5--z6 col;
spcharend(8);

% Lettre C
mwidth:=6;
spchar(67)
    x5=x1=2cx; y1=5cy;
    y3=barheight;
    x4=x2=0cx; y2=ho;
    x3=-2cx;
    y4=bo; y5=2cy;    
    spirou_half(1,2,3);
    spirou_half(3,4,5);
    gouache(1,0);
    gouache(5,0);
spcharend(5);

% Lettre Z
mwidth:=6;
spchar(90)
x1=-2cx;
y2=y1=ho;
x6=x3=x2=2cx;
y3=y2-0.5cy
y6=y5=bo; x5=x4=-2cx;
y4=bo+0.5cy;
cutdraw z1--z2--z3--z4--z5--z6 col;
%gouache(1,0);
%gouache(7,0);
spcharend(6);

% Lettre H
mwidth:=5;
spchar(900)
x5=x2=x1=-2cx;
x6=x4=x3=2cx;
y3=y1=b; y4=y2=h;
y6=y5=barheight;
cutdraw z1--z2 col;
cutdraw z3--z4 col;
cutdraw z5--z6 col;
gouache(1,0);
gouache(2,0);
gouache(3,0);
gouache(4,0);
spcharend(6);

% Lettre X
mwidth:=5;
spchar(88)
x4=x1=-2.5cx; y4=y2=b;
x3=x2=2.5cx; y3=y1=h;
cutdraw z1--z2 col;
cutdraw z3--z4 col;
gouache(1,28);
gouache(2,28);
gouache(3,145);
gouache(4,145);
spcharend(4);

% Lettre R bis
mwidth:=6;
spchar(162)
mcapheight:=VanishPointMean:=ho;
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

% Lettre R autre
mwidth:=6;
spchar(160)
plafond:=fuitebureau:=ho;
bureau:=plafond/3; % a faire varier
sol:=0;
mur:=-2cx;% a faire varier
balcon:=2cx;% a faire varier
fenetre:=-1.8cx;% a faire varier
fuite:=balcon*2;% a faire varier
stylo:=(fenetre-mur)/2;
x1:=x2:=x6:=x10:=mur;
y3:=y2:=plafond;
y1:=y7:=sol;
x3:=x5:=fenetre;
y8:=plafond/1.5; % a faire varier entre bureau et plafond ou plafond avec un diviseur
x8:=x11:=fuite/2;
y9:=bureau;
x9:=stylo;
z6:=whatever [z1,z2];
z6:=whatever [z9,z8];
z5:=whatever [z9,z8];
z5:=whatever [fenetre];
y10:=y2-((y2-y6)/2);
x4:=x7:=balcon;
y11:=plafond-((plafond-y8)/2);
z4:=whatever [z11,z10];
cutdraw z1 -- z2 .. z3{dir(angle(z3-z2))} ..tension 1.2.. z4 ..tension 1.2.. {dir(angle(z9-z8))}z5 .. z6 col;
cutdraw z5--z7 col;
spcharend(29);

% Lettre O
mwidth:=6;
spchar(79)
x1:=x3:=Middle;
x2:=LeftFoot;
x4:=RightFoot;
y1:=mbaseline;
y3:=mcapheight;
y2:=y4:=MeanLine;
cutdraw z1 .. z2 .. z3 .. z4 .. cycle col;
spcharend(6);

% Lettre test 
mwidth:=6;
spchar(666)
x1:=1cx;
y1:=0cy;
x2:=1cx;
y2:=21cy;
x3:=-3cx;
y3:=0cy;
cutdraw z1 -- z2 -- z3 col;
spcharend(3)

mwidth:=6;
  beginfig(667)
  mmiddlex:=(mwidth*u)/2;
  pickup pencircle xscaled mpenx yscaled mpeny;
  linejoin:=mitered;
mvariables; % injection de toutes les variables de lettrage
x1:=1mux;
y1:=0muy;
x2:=1mux;
y2:=21muy;
x3:=-3mux;
y3:=0muy;
cutdraw z1 -- z2 -- z3 col;
spcharend(3)

% Lettre 0 version 2
mwidth:=6;
spchar(790)
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

end
