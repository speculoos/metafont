prologues:=3; % ps output (remove the % if needed)
% outputtemplate := "%j%c.svg"; % exporter en svg.

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
enddef;

val:=.84; % courbes
fleche:=0; % courbes
tens:=.9; % tension

visual:=2; % 0 = sans grille , 1 = avec marges , 2 = avec marge + grille + numéros des points
marg:=0; % marge en x

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

defaultscale:=.2;

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
