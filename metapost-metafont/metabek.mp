prologues := 3;     % sortie EPS

% base unit
u:=10pt;

% x and y units
ux:=1u;
uy:=1u;

% function init pour générer une grille pour chaque glyphe avec argument "unicode" = nom glyphe+ "nombre de colonne" = cols
def init(suffix unicode, cols)=

beginfig(unicode);

    % numbers columns / lines
    nc:=cols;
    nl:=7;
    
    % 
    w:=nc*ux;
    h:=nl*uy;
    
    % pen size for grid
    p:=0.001cm;
    
    % gx (create vars x)
    numeric gx[];
    for i=0 upto nc:
    gx[i]=i*ux;
    endfor
    
    % gy (create vars y)
    numeric gy[];
    for i=0 upto nl:
    gy[i]=i*uy;
    endfor

    % pen for grid
    pickup pencircle scaled 1p;

    % loop draw gx
    for i=0 upto nc:
    draw (gx[i],gy[0])--(gx[i],gy[nl]);
    endfor 

    % loop draw gy
    for i=0 upto nl:
    draw (gx[0],gy[i])--(gx[nc],gy[i]);
    endfor

% pencircle
penw:=0.5u;
pickup pencircle xscaled penw yscaled penw rotated 45;

enddef;

%%%VARIABLES

% 65 = A
init(65, 5);
    z1=(0,0);
    z2=(0.5w, h-1.5penw);
    z12=0.4[z1, z2];
    z23=0.6[z2, z3];
    z3=(w, 0);
    draw z1--z2--z3;
    draw z12--z23;
endfig;

% 73= I ; 
init(73, 1);

    z1=(0.5w,0);
    z2=(0.5w, h);
    draw z1--z2;
endfig;

% 80 = P ; 5 = nombre de colonnes
init(80, 5);
    z1=(0,0);
    z2=(0,h);
    x3=3ux;
    y3=y2;
    x4=x3;
    y4=y6;
    z5=(w, (y2-y6)/2+y6);
    z6=(0,4uy);

    draw z1--z2--z3{right}..z5..{left}z4--z6;
endfig;

% 79 = O
init(79, 7);
    z1=(0.5w, 0+0.66penw);
    z2=(0, 0.5h);
    z3=(0.5w, h-0.66penw);
    z4=(w,0.5h);
    draw z1..z2..z3..z4..cycle;
endfig;

% 91 = T
init(91, 4);
    z1=(0, h);
    z2=(w, h);
    z3=(0.5w, h);
    z4=(0.5w,0);
    draw z1--z2;
    draw z3--z4;
endfig;

end

