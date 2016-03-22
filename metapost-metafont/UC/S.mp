input ../param
chasse:=6;
spchar(83)
    x1=2cx; y3=y1=5cy;
    x7=x2=0cx; y2=ho;
    x3=-2cx;
    x4=-1.25cx; y4=4cy;
    x5=1.5cx; y5=3cy;
    x6=2.25cx; y6=2cy; 
    y7=bo;
    x8=-2.25cx; y8=2.25cy
    spirou_half(1,2,3);
    draw z3{down}..z4..z5..{down}z6 col;
    spirou_half(6,7,8); 
spcharend(8);
end;
