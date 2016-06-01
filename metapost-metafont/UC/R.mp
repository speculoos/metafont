input ../param

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
end;
