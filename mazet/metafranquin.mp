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
u:=40pt;

% Chasse X
ux:=3u;

% Hauteur
uy:=3u;
h:=7uy;

% Graisses 
sas:=3u; %GRAISSE
sasx:=1sas; %GRAISSE X
sasy:=.8sas; %GRAISSE Y
ho:=h-(sasy/2); 
bo:=sasy/2;

% Traverses
barheight:=h/2;

% Courbes
val:=.84;
fleche:=0;

% Tension
tens:=.9;

% Preview
visual:=1; %0=Brut 1=Avec Chasse 2=Avec Chasse + Grille
marg:=0; %Marg en X

% Construction Darius
def build=
Baseline:=0;
CapHeight:=VanishPointMean:=ho;
MeanLine:=h/2;
Middle:=0cx;
LowerBowl:=CapHeight/4;
Pivot:=Middle;
Width:=4x;
LeftCorner:=-2cx;
RightCorner:=2cx;
Bridge:=sasx/3;
enddef;

% Caractère
def spchar(expr carac)=
  beginfig(carac)
  c:=(chasse*ux)/2;
  w:=chasse;
    def cx=
        ux+c;
    enddef;
    def cy=
        uy;
    enddef;
    def fcx=
        u+c;
    enddef;
    pair A,B;
    A:=(c,0u);
    B:=(c,7u);
    pickup pencircle xscaled sasx yscaled sasy;
    linejoin:=mitered;
build;
enddef;

% Courbe tensions
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
def col=
    if visual>1:
         withcolor .6white
    else:
    fi
enddef;

def spcharend(suffix n_points)=
pickup pencircle scaled 1;

if visual>=1:
    draw (-marg*ux,-2*uy)--((marg+chasse)*ux,-2*uy)--((marg+chasse)*ux,h+3u)--(-marg*ux,h+3u)-- cycle withcolor white;
    fi
    if visual>1:  
    pickup pencircle scaled 1.2
      for i=0 upto chasse:
        draw (i*ux,h)--(i*ux,0) withcolor blue;
    endfor
      for i=0 upto 7:
        draw (0*ux,i*uy)--(chasse*ux,i*uy) withcolor blue;
      endfor;

    defaultscale :=2.2;
    for i=1 upto n_points:
        dotlabels.top([i]);
    endfor;
fi
endfig
enddef;

def PVisual(suffix visual,i,j,k)=
  if visual>1:
    withcolor .6white;
  fi
enddef;

% Courbes spirou
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

% Pen
def pen_form(expr type_pen) =
  pickup type_pen scaled sas;
enddef;

% Diagonale
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


% ## Vocabulaire anatomique des lettres Darius

% CapHeight = Hauteur de la lettre
% UpperBowl
% LowerBowl
% BaseLine = Ligne de base
% Bridge = Traverse de la lettre
% MeanLine = Milieu de la case
% LowerBowl = Arrondis bas
% LeftCorner
% RighCorner
% Pivot
% Middle
% VanishingPoint
% Fuite = Point d'attraction de la courbe


% ## Vocabulaire anatomique des lettres 2

% baseline = ligne de base y
% baselinepen = ligne de base du tracé y
% baselinegouache = dépassement en-dessous baseline pour être gouaché y
% capheight = hauteur totale y
% capheightpen = hauteur du tracé de la lettre y
% capheighgouache = dépassement au-dessus capheight pour être gouaché y
% leftside = bord gauche
% leftsidepen = bord gauche du tracé
% rightside = bord droit
% rightsidepen = bord droit du tracé

% middley = ligne centre y
% middlex = ligne centre x
% upperbowly = ligne centre y de l'arrondi haut
% lowerbowly = ligne centre y de l'arrondi bas
% bridgex = tracé centre x compensé

% pivotx = ligne de pivotement de l'attraction x
% pivoty = ligne de pivotement de l'attraction y
% pivot = point de pivot
% fuitepoint = point d'attraction
% fuiteX = ligne d'attraction x
% fuiteY = ligne d'attraction y


% ## Types de lettres

% Droitues = E, F, H, I, L, T, 
% Pentues = A, K, M, N, V, W, X, Y, Z, 1, 4, 7
% Rondues = C, J, G, O, P, Q, R, 5, 6, 9, 0
% Flexues = S, 8


% ## Droitues

% Lettre E
chasse:=6;
spchar(69)
x4:=x1:=RightCorner;
y1:=y2:=bo;
x5:=x3:=x2:=LeftCorner;
y4:=y3:=CapHeight;
y6:=y5:=MeanLine + .25ux;
x6:=RightCorner- 0.5ux;
cutdraw z1 -- z2 -- z3 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre F
chasse:=6;
spchar(70)
x4:=x1:=RightCorner;
y1:=bo;
x5:=x3:=x2:=LeftCorner;
y2:=Baseline;
y4:=y3:=CapHeight;
y6:=y5:=MeanLine + .25ux;
x6:=RightCorner- 0.5ux;
cutdraw z2 -- z3 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre H
chasse:=6;
spchar(72)
x6:=x4:=x1:=RightCorner;
y2:=y1:=BaseLine;
x5:=x3:=x2:=LeftCorner;
y4:=y3:=h;
y6:=y5:=MeanLine - 1ux;
cutdraw z2 -- z3 col; 
cutdraw  z1 -- z4 col;
cutdraw z5 -- z6 col;
spcharend(6);

% Lettre I
chasse:=3;
spchar(73)
x2:=x1:=Middle;
y2:=h;
y3:=BaseLine;
cutdraw z1 -- z2 col; 
spcharend(6);

% Lettre L
chasse:=5;
spchar(76)
x4:=x1:=RightCorner - .5ux;
y1:=bo;
x5:=x3:=x2:=LeftCorner;
y2:=bo;
y4:=y3:=h;
cutdraw z1 -- z2 -- z3  col;
spcharend(6);

% Lettre T
chasse:=5;
spchar(84)
x2:=x1:=Middle;
y1:=BaseLine;
y3:=y4:=y2:=ho;
x3:=LeftCorner - .5ux;
x4:=RightCorner + .5ux;
cutdraw z1 -- z2 col; 
cutdraw z3 -- z4 col;
spcharend(4);


% Pentues

% Lettre A
chasse:=7;
spchar(65)
x1=LeftCorner - .5ux; 
y1=Baseline;
x2=Middle - Bridge; 
y3=y2=CapHeight;
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
chasse:=7;
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
chasse:=7;
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





% Anciennes

% Lettre D
chasse:=6;
spchar(68)
x2=x1=-2cx; y5=y1=bo;
y3=y2=ho;
x5=x3=0cx;
x4=2.25cx; y4=barheight;
spirou_crescent(3,4,5);
cutdraw z5--z1--z2--z3 col;
spcharend(5);

% Lettre N
chasse:=6;
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
chasse:=6;
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
chasse:=6;
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
chasse:=5;
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
chasse:=6;
spchar(66)
x6=x2=x1=-2cx; y8=y1=bo;
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
chasse:=6;
chasse:=6;
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
chasse:=6;
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
chasse:=5;
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
chasse:=5;
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
chasse:=6;
spchar(162)
CapHeight:=VanishPointMean:=ho;
MeanLine:=CapHeight/3; % a faire varier
Baseline:=0;
LeftFoot:=-2cx;% a faire varier
RightFoot:=2cx;% a faire varier
Middle:=0cx;% a faire varier
VanishPoint:=RightFoot*2;% a faire varier
Pivot:=(Middle-LeftFoot)/2;
x1:=x2:=x6:=x10:=LeftFoot;
y3:=y2:=CapHeight;
y1:=y7:=BaseLine;
x3:=x5:=Middle;
y8:=CapHeight/1.5; % a faire varier entre MeanLine et CapHeight ou CapHeight avec un diviseur
x8:=x11:=VanishPoint/2;
y9:=MeanLine;
x9:=Pivot;
z6:=whatever [z9,z8];
z5=whatever [z9,z8];
z5=whatever [Middle];
y10:=y2-((y2-y6)/2);
x4:=x7:=RightFoot;
y11:=CapHeight-((CapHeight-y8)/2);
z4:=whatever [z11,z10];
cutdraw z1 -- z2 .. z3{dir(angle(z3-z2))} ..tension 1.2.. z4 ..tension 1.2.. {dir(angle(z9-z8))}z5 .. z6 col;
cutdraw z5--z7 col;
spcharend(6);

% Lettre R autre
chasse:=6;
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

% Lettre P basé sur R
chasse:=6;
spchar(80)
headline:=fuitebureau:=ho;
bureau:=plafond/4;
baseline:=0;
boxleft:=-3cx;
boxright:=2cx;
fenetre:=balcon/6;
fuite:=balcon*4;
stylo:=(fenetre-mur)/2;
x1:=x2:=x6:=x10:=mur;
y2:=y3:=plafond;
y1:=sol;
x3:=x5:=fenetre;
y8:=fuitebureau;
x8:=fuite/2;
y9:=bureau;
x9:=stylo;
z6:=whatever [z1,z2];
z6:=whatever [z9,z8];
z5:=whatever [z9,z8];
z5:=whatever [fenetre];
y10:=y2-((y2-y6)/2);
x4:=x7:=balcon;
z4:=whatever [z10,z8];
cutdraw z1 -- z2 -- z3{right} ... z4 ... {dir(180+angle(z8-z9))}z5--z6 col;
spcharend(10)

% Lettre O
chasse:=6;
spchar(79)
x1:=x3:=Middle;
x2:=LeftFoot;
x4:=RightFoot;
y1:=BaseLine;
y3:=CapHeight;
y2:=y4:=MeanLine;
cutdraw z1 .. z2 .. z3 .. z4 .. cycle col;
spcharend(6);

% Lettre test 
spchar(666)
def //(suffix i,j) =
.. (.5[x.i,x.j]-.2ux, .5[y.i,y.j]) ..
enddef;
x1:=1cx;
y1:=0cy;
x2:=1cx;
y2:=7cy;
x3:=-3cx;
y3:=0cy;
cutdraw z1 //(1,2) z2 col;
spcharend(3)

end
