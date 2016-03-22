input ../param

chasse:=6;

spchar(80)
x6=x2=x1=-2cx; y1=0cy;
y3=y2=ho;
x5=x3=0cx; y6=y5=barheight-0.5cy;
x4=2.25cx; y4=y5+((ho-y5)/2); 
spirou_crescent(3,4,5);
cutdraw z1--z2--z3 col;
cutdraw z5--z6 col;
spcharend(6);
end;
