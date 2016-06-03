% ## Documentation
	% Guide http://tex.loria.fr/prod-graph/zoonekynd/metapost/metapost.html
	% Some pdfs :
	% http://antoine-gelgon.fr/MetaPost-Doc/
	% And
	% http://tex.stackexchange.com/questions/107489/what-is-metapost-metafont-and-how-can-i-get-started-using-it
	% Some simples examples to start :
	% http://tex.loria.fr/prod-graph/zoonekynd/metapost/metapost.html
	% http://www.ursoswald.ch/metapost/tutorial.html
	% Franquin notes :
	% https://github.com/speculoos/metafont
	% The Metadin repo:
	% https://github.com/osp/osp.foundry.metadin
	% Unicode
	% https://en.wikipedia.org/wiki/List_of_Unicode_characters#Basic_Latin
	% Partly translated in german - unicode tabelle auf deutsch : http://unicode-table.com/de

% ## Shell commands
	% To get the .mp in local:
	% curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && mpost metafranquin.mp
	
	% And in loop:
	% for (( ; ; )); do curl http://pads.osp.kitchen/p/metadin/export/txt > metafranquin.mp && mpost metafranquin.mp ; sleep 10; done
	
	% And without stopping on error and doing screenshots!
	% for (( ; ; )); do import -window root screen/$(date +%m-%d-%h-%m-%s).png sleep 100; done
	% for (( ; ; )); do import -window root screen/$(date +%s).png; sleep 100; done
	% And without stopping on error and doing screenshots!
	% for (( ; ; )); do curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && mpost -interaction=batchmode metafranquin.mp; sleep 10; done
	
% ## Functions and grid

prologues := 3; % ps output (remove the % if needed)

input param

%LETTER A
chasse:=6;

spchar(65)
x1=-2.5cx; y1=0cy;
x2=-1.3fcx; y3=y2=ho;
x3=0cx;
x4=-2cx; y5=y4=1.6cy;
x5=2cx;
path dleft,dright;
dleft=z1...{crb(1,2,tens)}z2--z3;
dright=dleft reflectedabout(A,B);

cutdraw dleft col;
cutdraw dright col;
cutdraw z4--z5 col;

gouache(1, 154, refl);
gouache(3, 0, sup);
spcharend(5);

%LETTER D
chasse:=6;
spchar(68)
x2=x1=-2cx; y5=y1=bo;
y3=y2=ho;
x5=x3=0cx;
x4=2.25cx; y4=barheight;
spirou_crescent(3,4,5);
cutdraw z5--z1--z2--z3 col;
spcharend(5);

% a point on a curve
chasse:=6;
spchar(70)
pickup pencircle xscaled 1u yscaled 1u;
path p;
	p = (0,0)..(6u,2u)..(12u,12u);
draw p;
draw point (length(p)/2) of p withpen pencircle scaled 1u;
draw (u/2,2u)--(point (length(p)/2) of p);
draw (0,0)--(length(p));
spcharend(5);

%LETTER N
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

% a point on a curve

beginfig(105)
    path p;
    p = (0,0){0,0.1uy} .. (3ux,0){down};
    draw p;
	z3=point .1 of p;
	z5=point .2 of p;
	z7=point .4 of p;
	z8=point .3 of p;
	z9=point 0 of p;
	
	z6=point .5 of p;
	z4=(1.5ux,0);
	draw z3--z4;
	draw z5--z4;
	draw z6--z4;
	draw z7--z4;
	draw z8--z4;
	draw z9--z4;
	
    %draw point 1  of p withpen pencircle scaled 4bp;
endfig;


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


chasse:=6;

spchar(120)
draw (0,0)--(0,6);

spcharend(5);


beginfig(150)
plafond=6;
bureau=plafond/2.5;
sol=0;
mur=0;
balcon=6;
fenetre=balcon/3*2;
lampe=(plafond-bureau)/2+bureau;

x1=x2=x6=mur;
y2=y3=plafond;
y5=y6=bureau;
y1=y7=sol;
x3=x5=fenetre;
x4=x7=balcon;
y4=lampe;

	draw z1--z2--z3{right}..z4..{left}z5--z6;
	draw z5--z7;
endfig;

chasse:=6;
spchar(160)

plafond:=fuitebureau:=ho;
bureau:=plafond/2;
sol:=0;
mur:=-3cx;
balcon:=3cx;
fenetre:=balcon/3*2;
lampe:=(plafond-bureau)/2+bureau;
fuite:=balcon*4;
stylo:=(fenetre-mur)/2;

x1:=x2:=x6:=x10:=mur;
y2:=y3:=plafond;
y1:=y7:=sol;
x3:=x5:=fenetre;
y8:=fuitebureau;
x8:=fuite/2;
y9:=bureau;
x9:=stylo;
z6:=whatever [z1,z2];
z6:=whatever [z9,z8];
z5:=whatever [z9,z8];
z5:=whatever [fenetre];
y10:=lampe;
x4:=x7:=balcon;
y4:=plafond*0.8;
cutdraw z1--z2--z3{right}..z4..{dir 203}z5--z6 col;
cutdraw z5--z7 col;
spcharend(10);

%LETTER M
chasse:=8;
spchar(77)
x2=x1=-3cx; 
x3=-2.75cx;
x4=0cx;
x5=2.75cx;
x7=x6=3cx;
y7=y1=0;
y6=y5=y3=y2=ho;
y4=1.5cy;
cutdraw z1--z2--z3--z4--z5--z6--z7 col;
gouache(2,0,sup);
gouache(6,0,sup);

gouache(1,0);
gouache(7,0);

spcharend(7);


%LETTER N
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
cutdraw z1--z2--z3--z4--z5--z6;
%gouache(2,0,sup);
%gouache(6,0,sup);

%gouache(1,0);
%gouache(7,0);

spcharend(6);


%LETTER K
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


%LETTER B
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


%LETTER C
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


%LETTER N
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


%LETTER H
chasse:=5;
spchar(72)

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


%LETTER X
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


end

