% for (( ; ; )); do curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && mpost -interaction=batchmode metafranquin.mp ; sleep 10; done
% pour basculer en sortie ps plutot que svg
%for (( ; ; )); do curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquins.mp && sed -e '22,23d' metafranquins.mp > metafranquin.mp && mpost -interaction=batchmode metafranquin.mp ; sleep 10; done

	
	% Unicode - https://en.wikipedia.org/wiki/List_of_Unicode_characters#Basic_Latin
	% 32 SP - 33 ! - 34 " - 35 # - 36 $ - 37 % - 38 & - 39 ' - 40 ( - 41 ) - 42 * - 43 + - 44 , - 45 - - 46 . - 47 / 
	% 48 0 - 49 1 - 50 2 - 51 3 - 52 4 - 53 5 - 54 6 - 55 7 - 56 8 - 57 9
	% 58 : - 59 ; - 60 < - 61 = - 62 > - 63 ? - 64 @
	% 65 A - 66 B - 67 C - 68 D - 69 E - 70 F - 71 G - 72 H - 73 I - 74 J - 75 K - 76 L - 77 M - 78 N - 79 O - 80 P - 81 Q - 82 R - 83 S - 84 T - 85 U - 86 V - 87 W - 88 X - 89 Y - 90 Z
	% 91 [ - 92 \ - 93 ] - 94 ^ - 95 _ - 96 `
	% 97 a - 98 b - 99 c - 100 d - 101 e - 102 f - 103 g - 104 h - 105 i - 106 j - 107 k - 108 l - 109 m - 110 n - 111 o - 112 p - 113 q - 114 r - 115 s - 116 t - 117 u - 118 v - 119 w - 120 x - 121 y - 122 z
	% 123 { - 124 | - 125 } - 126 ~ - 127 DEL
	
	% Droitues E F H I L T 
	% Pentues A K M N V W X Y Z 1 4 7
	% Rondues horizontales B D P R
	% Rondues verticales J S U 2 3 5
	% C G O Q 6 8 9 0
	
prologues:=3;
outputtemplate := "%j-%c.svg"; 
outputformat := "svg"; 

% Unités
u:=12pt;
xu:=1u; % unité de taille de base, à faire varier pour la chasse
yu:=1u; % unité de taille de base, à faire varier pour la chasse
xpen:=4.2u; % graisse x
ypen:=4.2u; % graisse y
visual:= 0; % 0 visualiser les glyphs en noir, 1 voir la grille et les points de construction

def mvariables=
	% Courbes
		mtension:=1; % courbes - entre .75 et 1.15 env
		mflexivity:=.04; % tension des droites flexibles entre 0 et .3 (neg pour inverser)
		zfuite:=0; % variable générale de cursivité, vitesse, fuite - entre 0 et 4 - sur le K entre 0 et 2
		mopen:=5;
		dish_gouache:= -50; % value default := -90;
	% Variables y
		ybaseline:=0yu; % ligne de base
		ycapheight:=21yu; % hauteur totale
		yleg:=ybaseline+ypen/2; % ligne de base du tracé horizontal
		yarm:=ycapheight-ypen/2; % hauteur du tracé haut horizontal
		ybaselineovershoot:=yleg-sqrt(ypen)/2; % ligne de base avec débordement overshoot
		ycapheightovershoot:=yarm+sqrt(ypen)/2; % hauteur du tracé avec débordement overshoot
		ybaselinegouache:=ybaseline - ypen/2; % dépassement en-dessous ybaseline pour gouache
		ycapheightgouache:=ycapheight+ypen/2; % dépassement au-dessus ycapheight pour gouache
		ybaselineoblique:=ybaseline - ypen/6; % dépassement en-dessous ybaseline pour oblique
		ycapheightoblique:=ycapheight+ypen/6; % dépassement au-dessus ycapheight pour oblique
		ycenter:=ycapheight/2; % ligne centre y
		yupbar:=ycenter+ypen; % tracé centre x compensé haut
		ylowbar:=ycenter-ypen/2; % tracé centre x compensé bas
		yupbowl:=ycapheight-((ycapheight-ylowbar)/2); % ligne centre y de l'arrondi haut
		ylowbowl:=ybaseline+(yupbar/2); % ligne centre y de l'arrondi bas
		yfuite:=yarm-((yarm-ylowbar)/1.5); % ligne d'attraction y - base=1, à relier à zfuite
		yempat:=0; %variation en y jambe R et K
	% Variables x
		xleftside:=0; % bord gauche
		xrightside:=xwidth; % bord droit
		xleftstem:=xleftside+xpen; % fût gauche du tracé vertical
		xrightstem:=xrightside-xpen; % fût droit du tracé vertical
		xleftovershoot:=xleftstem-xpen/2; % bord gauche overshoot
		xrightovershoot:=xrightstem+xpen/2; % bord droit overshoot
		xend:=xpen/3 - .5xpen; % valeur de largeur d'embouts
		xendoblique:=xpen/3; % valeur de largeur d'embouts obliques
		xcenter:=xwidth/2; % ligne centre x
		% xbigbowl:=xrightovershoot-xpen/4; % ligne centre x de l'arrondi grand
		% xsmallbowl:=xrightovershoot-xpen/2; % ligne centre x de l'arrondi petit
		xbowlattach:=xfuite/2; % le point d'attache de l'horizontale tangente au bowl
		xbridge:=xpen/4; % valeur d'écartement des pointes obliques
		ybridge:=ypen/4; % valeur d'écartement des pointes obliques
		% xpivot:=6u; % ligne de pivotement de l'attraction x - sans doute inutile
		xfuite:=2xwidth; % ligne d'attraction x
		xempat:=0; %variation en x jambe R et K 
		xpanse:=0; %variation panse BDPR 
		mreduc:=40; % utilisé dans mcurvec - semble valeur moyenne
		mreduc2:=6; % utilisé dans mcurvec - semble valeur moyenne
		
	pickup pencircle xscaled xpen yscaled ypen rotated 0;
	linejoin:=rounded;
enddef;

def mcolor= % gris de la lettre
	if visual >= 1:
		withcolor .6white
	else 
		withcolor black
	fi
enddef;

def mgrid(suffix mpoints)= % grille
	pickup pencircle scaled 0.2;
	if visual=1:
		for i=0 upto xwidth/xu: % grille verticale
			draw (xleftside+i*xu,ycapheight) -- (xleftside+i*xu,ybaseline) withcolor .8white;
		endfor
		for i=0 upto ycapheight/yu: % grille horizontale
			draw (xleftside,i*yu) -- (xrightside,i*yu) withcolor .8white;
		endfor;
		for i=1 upto mpoints: % entrée manuelle du nombre de points glyphe par glyphe (à automatiser?)
			dotlabels.bot([i]);
		endfor;
			draw (xleftside,ybaseline-8yu) -- (xleftside,ycapheight+2yu) -- (xrightside,ycapheight+2yu) -- (xrightside,ybaseline-8yu) -- cycle withcolor red;
	else
		draw (xleftside,ybaseline-8yu) -- (xleftside,ycapheight+2yu) -- (xrightside,ycapheight+2yu) -- (xrightside,ybaseline-8yu) -- cycle withcolor white;
	fi
enddef;

def mcurve(suffix i, mmove)= % courbes base
	if mmove=L:
		(x.i, y.i - mleft){up} .. (x.i, y.i + mleft){up}
	elseif mmove=R:
		(x.i, y.i + mright){down} .. (x.i, y.i - mright){down}
	fi
enddef;

def mcurver(suffix i, mmove, yshift)= % courbes base modifié pour le R
	if mmove=L:
		(x.i+xshift,y.i-yshift)...z.i...(x.i-xshift,y.i+yshift)
	elseif mmove=R:
		(x.i-yshift/10*(mtension-.75),y.i+yshift)...z.i...(x.i-yshift/10*(mtension-.75),y.i-yshift)
	fi
enddef;

def mcurvec(suffix i, mmove, mshift)= % courbes base modifié pour le C mais généralisé
	if mmove=yup:
		(x.i+(mshift*zfuite)/(mreduc*(yu/xu)),y.i-mshift-zfuite) .. z.i .. (x.i+mshift/(mreduc*(yu/xu)),y.i+mshift+zfuite)
	elseif mmove=ydown:
		(x.i-mshift/(mreduc*(yu/xu)),y.i+mshift+zfuite) .. z.i .. (x.i-(mshift*zfuite)/(mreduc*(yu/xu)),y.i-mshift-zfuite)
	elseif mmove=xright:
		(x.i-((mshift*xu)/(yu-(zfuite/mreduc2))),y.i-mshift/mreduc-(zfuite/mreduc2)) ... z.i ... (x.i+((mshift*xu)/(yu+(zfuite/mreduc2))),y.i-mshift/mreduc+(zfuite/mreduc2))
	elseif mmove=xleft:
		(x.i+((mshift*xu)/(yu+(zfuite/mreduc2))),y.i+mshift/mreduc+(zfuite/mreduc2)) ... z.i ... (x.i-((mshift*xu)/(yu-(zfuite/mreduc2))),y.i+mshift/mreduc-(zfuite/mreduc2))
	fi
enddef;
	
def mbridge(suffix i, mmove)=
	if mmove=ydown:
		(x.i, y.i) -- (x.i, y.i-ybridge)
	elseif mmove=yup:
		(x.i, y.i+ybridge) -- (x.i, y.i)
	elseif mmove=xcenter:
		(x.i - xbridge/2, y.i) -- (x.i + xbridge/2, y.i)
	elseif mmove=xright:
		(x.i + xbridge, y.i) -- (x.i, y.i)
	elseif mmove=xleft:
		(x.i, y.i) -- (x.i - xbridge, y.i)
	fi
enddef;
	
def mflex(suffix i, j,mforce,xshift,yshift)= % les lignes droites qui se courbent un peu
	 .. ((1+(mflexivity*mforce))[(xcenter+xshift,ycenter+yshift),.5[z.i,z.j]]) .. 
enddef;

def gouache(suffix i, j)= % WIP
		path shape;
		shape := (x.j+xpen/2, y.j+ypen/1.5) .. (x.j+xpen/1.70, y.j+ypen/1.75) .. (x.j+xpen/2, y.j+ypen/2) .. {dir dish_gouache}(x.j+xpen/2,y.j-ypen/2) .. (x.j+xpen/1.70,y.j-ypen/1.75) .. (x.j+xpen/2,y.j-ypen/1.5)-- (x.j-xpen/2, y.j-ypen/1.5) -- (x.j-xpen/2, y.j+ypen/1.5) -- cycle ; 

  unfill shape rotatedaround(z.j, angle(z.i - z.j));
enddef;

% Lettre M
beginfig(77);
	xwidth:=22xu;
	mvariables;
	u-m=:.5u;
	x1=xleftstem-zfuite*.5u;
	x2=x6=xleftstem+zfuite*.5u;
	x4=x7=xrightstem-zfuite*.5u;
	x5=xrightstem+zfuite*.5u;
	x3=xcenter;
	y1=ybaselinegouache;
	y2=y4=ycapheight;
	y3=ylowbar-zfuite*u;
	y5=ybaselinegouache;
	y6=y7=ycapheightgouache;
	draw z1 mflex(1,2,1) z2 mcolor;
	draw z2 mflex(2,3,1) z3 --  z3 mflex(3,4,1) z4  mcolor;
	draw z4 mflex(4,5,1) z5 mcolor;
	gouache(6,1);
	gouache(5,7);
	gouache(7,5);
	gouache(2,6);
	mgrid(7);
endfig;

% Chiffre 1
beginfig(49);
	xwidth:=15xu;
	mvariables;
	mflexivity:=.1;
	x1=xleftstem-xpen/2;
	x2=x4=x3=xrightstem;
	y1=yupbar;
	y2=ybaselinegouache;
	y4=ycapheightgouache;
	y3=yarm;
	cutdraw z2 mflex(2,3,0.5,0,0) mbridge(3,xleft) mflex (3,1,0.5,0,0) z1 mcolor; 
	% le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	gouache(4,2);
	gouache(3,1);
	gouache(2,4);
	mgrid(4);
endfig;


% Chiffre 4
beginfig(52);
	xwidth:=18xu;
	mvariables;
	mflexivity:=.1;
	x4=x5=xcenter-xend;
	x1=xcenter-2xend;
	x2=xendoblique-0,5xpen;
	x3=xrightside-xend;
	y1=ycapheightoblique;
	y4=yupbar;
	y2=y3=y6=ylowbar;
	y5=ybaselinegouache;
	x6=xleftside-0.5xpen;
	cutdraw z1 mflex(1,2,0.5,0,0) mbridge(2,yup) mflex(2,3,0.5,0,0) z3 mcolor;
	cutdraw z4 mflex(4,5,0.5,0,0) z5 mcolor;
	gouache(2,1);
	gouache(4,5);
	gouache(2,3);
	gouache(3,6);
	mgrid(6);
endfig;

% Chiffre 7
beginfig(55);
	xwidth:=18xu;
	mvariables;
	y1=y2=y4=ycapheight;
	y3=ybaselineoblique;
	x1=xleftside;
	x3=xleftside+xendoblique;
	x2=xrightside;
	x4=xrightside-xend;
	cutdraw z1 mflex(1,2,0.5,0,0) mbridge(2,ydown) mflex(2,3,0.5,0,0) z3 mcolor;
	gouache(1,4);
	gouache(2,3);
	gouache(2,1);
	mgrid(4);
endfig;

% Ponctuation !
beginfig(33);
	xwidth:=12xu;
	mvariables;
	y1=ycapheightgouache;
	y2=y4=yleg;
	y3=ybaselinegouache;
	x1=x2=x3=x4=xcenter;
	cutdraw z1 mflex(1,2,0.5,0,0) z2 mcolor;
	cutdraw z3 mflex(3,4,0.5,0,0) z4 mcolor;
	gouache(2,1);
	gouache(1,2);
	gouache(4,3);
	mgrid(4);
endfig;

% Ponctuation -
beginfig(45);
	xwidth:=16xu;
	mvariables;
	y1=y2=ylowbar;
	x1=xleftside;
	x2=xrightside;
	cutdraw z1 mflex(1,2,0.5,0,0) z2 mcolor;
	gouache(2,1);
	gouache(1,2);
	mgrid(4);
endfig;

% Ponctuation .
beginfig(46);
	xwidth:=16xu;
	mvariables;
	x1=x2=xcenter;
	y1=yleg;
	y2=ybaselinegouache;
	cutdraw z1 mflex(1,2,0.5,0,0) z2 mcolor;
	gouache(2,1);
	gouache(1,2);
	mgrid(2);
endfig;

% Ponctuation :
beginfig(58);
	xwidth:=16xu;
	mvariables;
	x1=x2=x3=x4=xcenter;
	y1=y3=yleg;
	y2=ybaselinegouache;
	y4=yleg+ypen;
	cutdraw z1 mflex(1,2,0.5,0,0) z2 mcolor;
	cutdraw z3 mflex(3,4,0.5,0,0) z4 mcolor;
	%gouache(2,1);
	%gouache(1,2);
	%gouache(3,4);
	mgrid(4);
endfig;

% Lettre E
beginfig(69);
	xwidth:=15xu;
	mvariables;
	x1=x5=x6=xrightside - xend;
	x2=x4=xleftstem;
	y1=y2=yleg;
	y4=y5=yarm;
	y3=y6=ycenter-.5u;
	z3=whatever[(x2 - mflexivity, y2), z4];
	cutdraw z1 mflex(1,2,1,1,0) z2 -- z2 mflex(2,4,0.5,0,0) z4 -- z4 mflex(4,5,0.5,0,0) z5 mcolor; % le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	cutdraw z3 (mflex3,6,.5,0,0) z6 mcolor;
	gouache(2,1);
	gouache(3,6);
	gouache(4,5);
	mgrid(6);
endfig;

% Lettre F
beginfig(70);
	xwidth:=15xu;
	mvariables;
	x5=x6=xrightside - xend;
	x2=x4=xleftstem;
	y2=ybaselinegouache;
	y4=y5=yarm;
	y3=y6=ycenter+0.5u;
	z3=whatever[(x2 - mflexivity, y2), z4];
	cutdraw z2 mflex(2,4,0.5,0,0) z4 -- z4 mflex(4,5,0.5,0,0) z5 mcolor; % le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	cutdraw z3 mflex(3,6,0.5,0,0) z6 mcolor;
	gouache(4,2);
	gouache(4,5);
	gouache(3,6);
	mgrid(12);
endfig;

% Lettre H
beginfig(72);
	xwidth:=20xu;
	mvariables;
	x1=x5=x6=xrightstem;
	x2=x4=xleftstem;
	y1=y2=ybaselinegouache;
	y4=y5=ycapheightgouache;
	y3=y6=ycenter;
	z3=whatever[(x2 - mflexivity, y2), z4];
	cutdraw z2 mflex(2,4,0.5,0,0) z4  mcolor; 
	cutdraw z1 mflex(1,5,0.5,0,0) z5 mcolor;
	cutdraw z3 mflex(3,6,0.5,0,0) z6 mcolor;
	gouache(4,2);
	gouache(5,1);
	gouache(2,4);
	gouache(1,5);
	mgrid(12);
endfig;

% Lettre L
beginfig(76);
	xwidth:=15xu;
	mvariables;
	x1=xrightside - xend;
	x2=x4=xleftstem;
	y1=y2=yleg;
	y4=ycapheightgouache;
	cutdraw z1 mflex(1,2,1,0,0) z2 -- z2 mflex(2,4,.5,0,0) z4 mcolor; % le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	gouache(2,1);
	gouache(2,4);
	mgrid(12);
endfig;

% Lettre I
beginfig(73);
	xwidth:=15xu;
	mvariables;
	x2=x4=xcenter;
	y2=ybaselinegouache;
	y4=ycapheightgouache;
	cutdraw z2 mflex(2,4,.5,0,0) z4 mcolor; % le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	gouache(4,2);
	gouache(2,4);
	mgrid(4);
endfig;

% Lettre T
beginfig(84);
	xwidth:=18xu;
	mvariables;
	x2=x4=xcenter;
	y2=ybaselinegouache;
	y3=y5=y4=yarm;
	x3=xleftside;
	x5=xrightside;
	cutdraw z2 mflex(2,4,.5,0,0) z4 mcolor; 
	cutdraw z3 mflex(3,5,.2,0,0) z5 mcolor; % le premier point de tension entre points 2 et 4, le second dédoublé pour casser sa continuité de courbe
	gouache(4,2);
	gouache(4,3);
	gouache(4,5);
	mgrid(12);
endfig;

% Lettre Y
beginfig(89);
	xwidth:=16xu;
	mvariables;
	x2=x4=xcenter;
	y2=ybaselinegouache;
	y3=y5=ycapheightgouache;
	x3=xleftside;
	x5=xrightside;
	y4=ycenter-3u;
	cutdraw z2 mflex(2,4,.5,0,0) z4 mcolor; 
	cutdraw z3 mflex(3,4,.2,0,0) z4 mcolor; 
	cutdraw z5 mflex(5,4,.2,0,0) z4 mcolor; 
	gouache(4,3);
	gouache(4,5);
	gouache(4,2);
	mgrid(12);
endfig;

% Lettre X
beginfig(88);
	xwidth:=16xu;
	mvariables;
	y2=y4=ybaselinegouache;
	y3=y5=ycapheightgouache;
	x3=x2=xleftside;
	x5=x4=xrightside;
	cutdraw z3 mflex(3,4,0,0,0) z4 mcolor; 
	cutdraw z5 mflex(5,2,0,0,0) z2 mcolor; 
	gouache(5,2);
	gouache(4,3);
	gouache(2,5);
	gouache(3,4);
	mgrid(12);
endfig;

% Lettre V
beginfig(86);
	xwidth:=17xu;
	mvariables;
	x2=xcenter-xbridge/2;
	x4=xcenter+xbridge/2;
	y2=y4=yleg;
	y3=y5=y6=ycapheightgouache;
	x3=xleftside;
	x5=xrightside;
	x6=x7=.5[x2,x4];
	y7=ybaseline;
	cutdraw z3 mflex(3,2,.2,0,0) z2 -- z4 mflex(4,5,.2,0,0) z5 mcolor;
	%cutdraw z5 mflex(5,4,.2,0,0) z4 mcolor; 
	%cutdraw z4 mflex(4,2,.2,0,0) z2 mcolor; 
	gouache(4,3);
	gouache(4,5);
	gouache(6,7);
	mgrid(12);
endfig;

% Lettre W
beginfig(87);
	xwidth:=25xu;
	mvariables;
	x2=xwidth/4;
	x4=xwidth/4+xbridge;
	y2=y4=y8=y9=yleg;
	y3=y7=y10=y13=y14=ycapheightgouache;
	y11=y12=y15=ybaseline;
	y5=y6=yarm;
	x10=x11=.5[x2,x4];
	x12=x13=.5[x9,x8];
	x14=x15=.5[x5,x6];
	x3=xleftside;
	x5=xcenter-xbridge/2;
	x6=xcenter+xbridge/2;
	x8=xwidth/4*3;
	x9=xwidth/4*3-xbridge;
	x7=xrightside;
	cutdraw z3 mflex(3,2,.2,0,0) z2 -- z4 mflex(4,5,.2,0,0) z5 --  z6 mflex(6,9,.2,0,0) z9 -- z8 mflex(8,7,.2,0,0) z7 mcolor;
	gouache(2,3);
	gouache(8,7);
	gouache(10,11);
	gouache(13,12);
	gouache(15,14);
	mgrid(15);
endfig;

% Lettre Z
beginfig(90);
	xwidth:=18xu;
	mvariables;
	y2=y4=y1=ybaseline;
	y3=y5=y6=ycapheight;
	x1=xleftside+xend;
	x2=x3=xleftside;
	x5=x4=xrightside;
	x6=xrightside-xend;
	cutdraw z3 mflex(3,5,0.5,1,1) mbridge(5,ydown) mflex(5,2,0.5,1,1) mbridge(2,yup) mflex (2,4,0.5,1,1) z4 mcolor; 
	gouache (6,3);
	gouache (3,6);
	gouache (4,1);
	gouache (1,4);
	mgrid(6);
endfig;
	
% Lettre A
beginfig(65);
	xwidth:=18xu;
	mvariables;
	x1= xleftside+xendoblique;
	x4= xrightside-xendoblique;
	x2= xcenter-xbridge/2;
	x3= xcenter+xbridge/2;
	y1= y4=y7=ybaselinegouache;
	y2= y3= yarm;
	y5= y6= ylowbar-ypen/2;
	x7=x8=0.5[x2,x3];
	y8=ycapheightgouache;
	%x5= whatever[x1, x2]; fait crasher méchamment
	z5:= whatever[(x1 - mflexivity, y1), z2];
	z6:= whatever[(x4 + mflexivity, y4), z3];
	%cutdraw z1 .. z5 .. z2 -- z3 .. z6 .. z4 mcolor;
      cutdraw z1 mflex(1,2,1) z2 -- z3 mflex(3,4,1) z4 mcolor;
	cutdraw z5 -- z6 mcolor;
	gouache(2,1);
	gouache(3,4);
	gouache(7,8);
	mgrid(8);
endfig;

	% Lettre K - z3 et z5 dépendent de zfuite et on ne connait pas la fourchette de valeur optimale (2 semble trop)
beginfig(75);
	xwidth:=20xu;
	mvariables;
	x1=x2=xleftstem;
	x6=(xrightside-xendoblique)+(xempat*u);
	x4=xrightside-1.5xendoblique; 
	x3=xleftstem+xpen/((zfuite*6u)+6);
	y1=ybaselinegouache;
	y6=ybaselineoblique+(yempat*u);
	y2=ycapheightgouache;
	y4=ycapheightoblique;
	y3=ycenter-zfuite*4u;
	y5=y3+zfuite*2yu;
	z5=whatever[z3,z4];
	cutdraw z1 mflex(1,2,1) z2 mcolor;
	cutdraw z3 mflex(3,4,1) z4 mcolor;
	cutdraw z5 mflex(5,6,1) z6 mcolor;
	gouache(2,1)
	gouache(1,2);
	gouache(5,4);
	gouache(5,6)
	mgrid(6);
endfig;

% Lettre N
beginfig(78);
	xwidth:=18xu;
	mvariables;
	x1=x2=x5=xleftstem;
	x3=x4=x6=xrightstem;
	y1=y6=ybaselinegouache;
	y2=ycapheight;
	y3=ybaseline;
	y4=y5=ycapheightgouache;
	linejoin:=beveled;
	cutdraw z1 mflex(1,2,1) z2 -- z2 mflex(2,3,10,xu,yu) z3 -- z3 mflex(3,4,1) z4 mcolor;
	gouache(5,1);
	gouache(1,5);
	gouache(3,6);
	gouache(3,4);
	mgrid(6);
endfig;

% Lettre O
beginfig(79);
	xwidth:=20xu;
	mvariables;
	x1=x3=xcenter;
	x2=xleftovershoot;
	x4=xrightovershoot;
	y1=ybaselineovershoot;
	y3=ycapheightovershoot;
	x9=xcenter;
	y9=ycenter;
	x8=xwidth;
	y8=ycenter+(zfuite*yu);
	z2=z5=whatever[z8,z9];
	z4=z6=whatever[z8,z9];
	path circleo;
	circleo:= mcurvec(1,xleft,4) ..tension (mtension).. mcurvec(2,yup,1yu)  ..tension (mtension).. mcurvec(3,xright,4)  ..tension (mtension).. mcurvec(4,ydown,1yu)  ..tension (mtension).. cycle; 
	cutdraw circleo mcolor;
	mgrid(11);
endfig;

% Lettre Q
beginfig(81);
	xwidth:=20xu;
	mvariables;
	xempat:=0;
	yempat:=0;
	zfuite:=0;
	xfuite:=1xwidth;
	xbowlattach:=xfuite/4;
	mtension:=1; % entre 0.75 et 1
	
	x1=x3=xcenter;
	x2=xleftovershoot;
	x4=xrightovershoot;
	x10=xcenter;
	x11=xcenter + (xempat*u);
	y1=ybaselineovershoot;
	y3=ycapheightovershoot;
	x9=xcenter;
	y9=ycenter;
	x8=xwidth;
	y8=ycenter+(zfuite*yu);
	y10=.9[y1,y9];
	y11=ybaselinegouache-4u-(yempat*u);
	z2=z5=whatever[z8,z9];
	z4=z6=whatever[z8,z9];
	path circleo;
	circleo:= mcurvec(1,xleft,4) ..tension (mtension).. mcurvec(2,yup,1yu)  ..tension (mtension).. mcurvec(3,xright,4)  ..tension (mtension).. mcurvec(4,ydown,1yu)  ..tension (mtension).. cycle; 
	cutdraw circleo mcolor;
	cutdraw z10 mflex (10,11,1) z11 mcolor;
	gouache(10,11);
	gouache(11,10);
	
	mgrid(11);
endfig;

% Lettre B version 1
%beginfig(66);
	%xwidth:=18xu; % entre 12xu et 22 xu
	%mvariables;
	%xfuite:=1.4xwidth; % entre 0.9 et 3 
	%zfuite:=0; % entre -1 et 4
	%mtension:=.8; %entre .8 et 1.3
	%xpanse:=0;variation panse  ; 
	
	%xbowlattach:=xfuite/4;
	%x1=x2=x6=x10=x7=xleftstem;
	%x3=x5=x16=xbowlattach;
	%x4=x15=xrightovershoot+(xpanse*u);
	%x8=x11=x12=x13=x14=xfuite;
	%x9=.7[x6,x5];
	%z9=whatever[z6,z5];
	%y1=yleg;
	%y14=yleg+(zfuite*u); 
	%y2=y3=y11=yarm;
	%y8=((yarm-yleg)/2)+(zfuite*u); 
	%y6=((yarm-yleg)/2)-(zfuite*u);
	%z5=whatever[z6,z8];
	%z4=whatever[z10,z12];
	%z15=whatever[z7,z13];
	%z16=whatever[z1,z14];
	%y7=.5[y1,y6];
	%y13=.5[y14,y8];
	%y10=.5[y6,y2];
	%y12=.5[y11,y8];
	%cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 -- z6 -- z6 .. z5{dir(angle(z5-z6))}  ..tension (mtension).. mcurver (15,R,16) ..tension (mtension).. {dir(angle(z1-z16))}z16 -- z1 .. cycle mcolor;
	
	%cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension)..  {dir(angle(z6-z5))}z5 -- z6 mcolor;
	%cutdraw z6 -- z6 .. z5{dir(angle(z5-z6))}  ..tension (mtension).. mcurver (15,R,16) ..tension (mtension).. {dir(angle(z1-z16))}z16 -- z1 .. cycle mcolor;
	mgrid(16);
%endfig;

% Lettre B
beginfig(66);
	xwidth:=18xu; % entre 12xu et 22 xu
	mvariables;
	xfuite:=1.8xwidth; % entre 1.2 et 2.5 
	zfuite:=0; % entre -1 et 4
	mtension:=1; %entre .8 et 1.3
	xpanse:=2;variation panse  ; 
	
	xbowlattach:=xfuite/4;
	x1=x2=x6=x10=x7=xleftstem;
	x3=x5=x16=xbowlattach;
	x4=x15=xrightovershoot+(xpanse*u);
	x8=x11=x12=x13=x14=xfuite;
	x17=.4[x5,x8];
	%y1=yleg-(zfuite*u);
	%y14=yleg+(zfuite*u); 
	y1=y16=y14=yleg;
	y2=y3=y11=yarm;
	y8=((yarm/2)+(yleg/2))+(zfuite*u); 
	y6=((yarm/2)+(yleg/2))-(zfuite*u);
	z5=whatever[z6,z8];
	z4=whatever[z10,z12];
	z15=whatever[z7,z13];
	z16=whatever[z1,z14];
	z17=whatever[z5,z8];
	y7=.5[y1,y6];
	y13=.5[y14,y8];
	y10=.5[y6,y2];
	y12=.5[y8,y11];
	

	
	cutdraw z1 mflex(1,6,.3) z6 -- z6 .. z5{dir(angle(z5-z6))} ..tension (mtension).. mcurver(15,R,16) ..tension (mtension).. {dir(angle(z1-z16))}z16 -- z1 .. cycle withcolor green;
	cutdraw z6 mflex(6,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 mcolor;
	
	
	%cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,17) ..tension (mtension).. {dir(angle(z6-z17))}z17 -- z6 -- z6 .. z5{dir(angle(z5-z6))}  ..tension (mtension).. mcurver (17,R,16) ..tension (mtension).. {dir(angle(z1-z16))}z16 -- z1 .. cycle mcolor;
	
	%cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 mcolor;
	%cutdraw z6 -- z6 .. z5{dir(angle(z5-z6))}  ..tension (mtension).. mcurver (15,R,16) ..tension (mtension).. {dir(angle(z1-z16))}z16 -- z1 .. cycle mcolor;
	
	mgrid(17);
endfig;

% Lettre D 
beginfig(68);
	%xwidth:=18xu; % entre 12xu et 22 xu
	mvariables;
	%xfuite:=1.4xwidth; % entre 0.9 et 2.5 
	%zfuite:=8; % entre 0 et 8
	%mtension:=1; %entre .8 et 1.3
	%xpanse:=0; %variation panse 
	
	xbowlattach:=xfuite/4;
	x2=x6=x10=xleftstem;
	x3=x5=xbowlattach;
	x4=xrightovershoot+(xpanse*u);
	x8=x11=x12=xfuite;
	y2=y3=y11=yarm;
	y8=ybaselineovershoot+(zfuite*u); 
	y6=ybaselineovershoot+(zfuite*(u/8));
	z5=whatever[z6,z8];
	z4=whatever[z10,z12];
	y10=.5[y6,y2];
	y12=.5[y11,y8];
	cutdraw z6 mflex(6,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 -- z6 .. cycle mcolor;
	mgrid(13);
endfig;

% Lettre P
beginfig(80);
	xwidth:=18xu; % entre 12xu et 22 xu
	mvariables;
	%xfuite:=1xwidth; % entre 0.9 et 3 
	%zfuite:=3.5; % entre -1 et 4
	%mtension:=1.3; %entre .8 et 1.3
	%xpanse:=0;variation panse  ; 
	
	xbowlattach:=xfuite/4;
	x1=x2=x6=x10=xleftstem;
	x3=x5=xbowlattach;
	x4=xrightovershoot+(xpanse*u);
	x8=x11=x12=xfuite;
	x9=.7[x6,x5];
	z9=whatever[z6,z5];
	y1=ybaselinegouache;
	y2=y3=y11=yarm;
	y8=ylowbar+(zfuite*u); ;
	y6=ylowbar-(zfuite*u);
	z5=whatever[z6,z8];
	z4=whatever[z10,z12];
	y10=.5[y6,y2];
	y12=.5[y11,y8];
	cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 mcolor;
	gouache(2,1);
	mgrid(13);
endfig;

% Lettre R
beginfig(82);
	xwidth:=18xu; % entre 12xu et 22 xu
	mvariables;
	%xfuite:=2xwidth; % entre 0.9 et 3 
	%zfuite:=0; % entre -1 et 4
	%mtension:=.8; %entre 1 et 1.3
	
	xbowlattach:=xfuite/4;
	x1=x2=x6=x10=xleftstem;
	x3=x5=xbowlattach;
	x4=xrightovershoot+(xpanse*u);
	x7=xrightside+(xempat*u);
	x8=x11=x12=xfuite;
	x9=.7[x6,x5];
	z9=whatever[z6,z5];
	y1=ybaselinegouache;
	y7=ybaselineoblique+(yempat*u);
	y2=y3=y11=yarm;
	y8=ylowbar+(zfuite*u); ;
	y6=ylowbar-(zfuite*u);
	z5=whatever[z6,z8];
	z4=whatever[z10,z12];
	y10=.5[y6,y2];
	y12=.5[y11,y8];
	cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5) ..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 mcolor;
	%cutdraw z5 mflex(5,7,3) z7 mcolor;
	 cutdraw z9 mflex(9,7,3)z7 mcolor; % si xwidth entre 2.7 et 3
	gouache(2,1);
	%gouache(5,7);
	gouache (9,7);
	mgrid(13);
endfig;
	
	
	% Lettre R ancien code
	%beginfig(82);
	%xwidth:=18xu;
	%mvariables;
	%mtension:=1;
	%x1=x2=x10=x6=xleftstem;
	%x3=x5=xbowlattach;
	%x4=xrightovershoot;
	%x7=xrightside-xendoblique;
	%x9=xpivot; 
	%x8=x11=x12=xfuite;
	%y1=ybaselinegouache;
	%y7=ybaselineoblique;
	%y2=y3=y11=yarm;
	%y9=ylowbar;
	%y8=yfuite;
	%z6=whatever[z9,z8];
	%z5=whatever[z9,z8];
	%z5=whatever[xbowlattach];
	%z4=whatever[z10,z12];
	%y10=y2-((y2-y6)/2);
	%y12=y11-((y11-y8)/2);
	%cutdraw z1 mflex(1,2,.3) z2 -- z2 .. z3{dir(angle(z3-z2))} ..tension (mtension).. mcurver(4,R,5)..tension (mtension).. {dir(angle(z6-z5))}z5 -- z6 mcolor;
	%cutdraw z5 mflex(5,7,3) z7 mcolor;
	%gouache(2,1);
	%gouache(5,7);
	%mgrid(13);
	%endfig;
	
% Lettre C
beginfig(67);
	xwidth:=20xu;
	mvariables;
	% mtension:=.9;  entre .75 et 2 (?)
	% zfuite:=2; % entre 0 et 4
	x1=x3=xcenter;
	x2=xleftovershoot;
	x4=xrightovershoot;
	y1=ybaselineovershoot;
	y3=ycapheightovershoot;
	x9=xcenter;
	y9=ycenter;
	x8=xwidth;
	y8=ycenter+(zfuite*yu);
	z2=z5=whatever[z8,z9];
	z4=z6=whatever[z8,z9];
	x12=;
	y12=;
	% mreduc:=25;
	path circlec;
	circlec:= mcurvec(1,xleft,4) ..tension (mtension).. mcurvec(2,yup,1yu)  ..tension (mtension).. mcurvec(3,xright,4)  ..tension (mtension).. mcurvec(4,ydown,1yu)  ..tension (mtension).. cycle; 
	% pickup pencircle xscaled 30 yscaled 90;
	linecap := butt;
	cutdraw circlec mcolor;
	undraw subpath(8+(zfuite/40)+(mopen/12),12-(zfuite/40)-(mopen/16)) of circlec;
	% z10:=point(8.5) of circlec;
	% z11:=point(11.5) of circlec;
	% gouache(9,10);
	% gouache(9,11);
	mgrid(12);
endfig;

	% path trace;
	% trace:= z1 ..tension (mtension).. mcurve(2, L) ..tension (mtension).. z3 ..tension (mtension).. mcurve(4, R) ..tension (mtension).. cycle; 
	% cutdraw trace mcolor;
	% undraw subpath(3.2,5.8) of trace; % outiller avec pivot
	%cé:= z1 ..tension (mtension).. mcurve(2,L) ..tension (mtension).. z3 ..tension(mtension).. mcurve(4,R) ..tension (mtension).. cycle; 
	%cé:= z1 ..tension (mtension).. mcurvec(2,yup,.2) ..tension (mtension).. z3 ..tension(mtension).. mcurvec(4,ydown,.2) ..tension (mtension).. cycle; 
	%cé:= z1 .. mcurvec(2,yup,4u) .. z3 .. mcurvec(4,ydown,4u) .. cycle; 
	%cé:= mcurvec(1,xleft,4u) .. mcurvec(2,yup,4u) .. mcurvec(3,xright,4u) .. mcurvec(4,ydown,4u) .. cycle; 
	%cé:= mcurvec(1,xleft,2xu) ... mcurvec(2,yup,4yu) ... mcurvec(3,xright,2xu) ... mcurvec(4,ydown,4yu) ... cycle; 
	%cé:= mcurvec(1,xleft,.5xu) ... mcurvec(2,yup,1yu) ... mcurvec(3,xright,.5xu) ... mcurvec(4,ydown,1yu) ... cycle; 

% Lettre G
beginfig(71);
	xwidth:=20xu;
	mvariables;
	x1=x3=xcenter;
	x2=xleftovershoot;
	x4=xrightovershoot;
	y1=ybaselineovershoot;
	y3=ycapheightovershoot;
	x9=xcenter;
	y9=ycenter;
	x8=xwidth;
	y8=ycenter+(zfuite*yu);
	z2=z5=whatever[z8,z9];
	z4=z6=whatever[z8,z9];
	y12=y13=ylowbar;
	x12=xrightside;
	x13=xcenter;
	linecap := butt;
	path circleg, barg;
	circleg:= mcurvec(1,xleft,4) ..tension (mtension).. mcurvec(2,yup,1yu)  ..tension (mtension).. mcurvec(3,xright,4)  ..tension (mtension).. mcurvec(4,ydown,1yu)  ..tension (mtension).. cycle; 
	cutdraw circleg mcolor;
	% barg:= z12 mflex(12,13,.5,0,-2yu) z13
	barg:= z12 -- z13
	% cutdraw barg mcolor;
	numeric ag,bg;
	(ag,whatever) = circleg intersectiontimes barg;
	undraw subpath(8+(zfuite/40)+(mopen/12),ag) of circlec;
	cutdraw z13 -- (point ag of circleg) mcolor;
	% z10:=point(8.5) of circlec;
	% z11:=point(11.5) of circlec;
	% gouache(9,10);
	% gouache(9,11);
	mgrid(11);
endfig;

% Lettre U
beginfig(85);
	xwidth:=15xu;
	mvariables;
	xfuite:=1xwidth; % ligne d'attraction x
	yfuite:=(ycapheightovershoot - ybaselineovershoot) / 2 + ybaselineovershoot;
	mtension:=0.75;
	x1=x2=xleftstem;
	x3=xcenter;
	x4=x5=xrightstem;
	y1=y5=ycapheightgouache;
	
	cutdraw z1 ..tension 0.75 and 0.75.. z2{up} ..tension 0.75 and 0.75.. z5{up} ..tension 0.75 and 0.75.. z3 ..tension 0.75 and 0.75.. z6{down} ..tension 0.75 and 0.75.. z4{down} mcolor;
	mgrid(12);
endfig;

% Lettre U
%beginfig(85);
	%xwidth:=15xu;
	%mvariables;
	%xfuite:=1xwidth; % ligne d'attraction x
	%yfuite:=(ycapheightovershoot - ybaselineovershoot) / 2 + ybaselineovershoot;
	%mtension:=0.75;
	%x1=x3=xcenter;
	%x2=x5=xleftovershoot;
	%x4=x6=xrightovershoot;
	%y1=ybaselineovershoot;
	%y3=ycapheightovershoot;
	%x9=xcenter;
	%y9=ycenter;
	%x8=xfuite;
	%y8=yfuite;
	%z2=z5=whatever[z8,z9];
	%z4=z6=whatever[z8,z9];
	%y2=y4:=ycenter-0yu;
	%y5=y6:=ycenter+0yu;
	%cutdraw z1 ..tension 0.75 and 0.75.. z2{up} ..tension 0.75 and 0.75.. z5{up} ..tension 0.75 and 0.75.. z3 ..tension 0.75 and 0.75.. z6{down} ..tension 0.75 and 0.75.. z4{down} mcolor;
	mgrid(12);
%endfig;

% tentative d'obtenir un z6 sur le mflex stem
	% path rstem;
	% path rlowbar;
	% rstem:=z1 mflex(1,2,.5) z2;
	% rlowbar:=z5--z6;
	% numeric (rcrossing,rvoid);
	% (rcrossing,rvoid)=rstem intersectiontimes rlowbar;
	% z13=point rcrossing of rstem;
	
	% def mcurvec(suffix i, mdirec, mshift)= % courbes base modifié pour le C généralisé
	mreduct:=5;
	if mdirec=U:
		(x.i+mshift/mreduct,y.i-mshift)...z.i...(x.i+mshift/mreduct,y.i+mshift)
	elseif mdirec=D:
		(x.i-mshift/mreduct,y.i+mshift)...z.i...(x.i-mshift/mreduct,y.i-mshift)
		%(x.i-yshift/10*(mtension-.75),y.i+yshift)...z.i...(x.i-yshift/10*(mtension-.75),y.i-yshift)
	fi
	% enddef;
	
end;
