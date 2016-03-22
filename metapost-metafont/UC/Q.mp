input ../param

chasse:=6;
spchar(79)
x1=x4=0cx;
y1=ho;
y4=bo;
x2=-2.25cx; x3=2.25cx;
y2=y3=barheight;
x5=0cx; y5=2cy;
x6=2cx; y6=-0.7cy;
spirou_half(2,1,3);
spirou_half(2,4,3);
cutdraw z5--z6 col;
spcharend(6);
end;
