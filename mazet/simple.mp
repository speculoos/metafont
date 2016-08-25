prologues:=3;
beginfig(30)
defaultscale:=200;
u:=20;
pickup pencircle yscaled 20 xscaled 30;
linejoin:=mitered;
x1:=x5:=x6:=5u;
x2:=x3:=x4:=0u;
y1:=y2:=0u;
y4:=y5:=8u;
y3:=y6:=5u;
cutdraw z1 -- z2 -- z4 -- z5;
cutdraw z3 -- z6;
endfig
end
