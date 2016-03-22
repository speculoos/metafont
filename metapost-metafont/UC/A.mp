input ../param

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
spcharend(5);
end;
