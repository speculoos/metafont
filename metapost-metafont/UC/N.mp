input ../param

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
spcharend(6);
end;
