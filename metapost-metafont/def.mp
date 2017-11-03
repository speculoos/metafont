def spchar(expr carac)=
  beginfig(carac)
  c:=(chasse*ux)/2;
  w:=chasse;
    def cx=
	ux+c;
    enddef;
    def cy=
	uy;
    enddef;
    def fcx=
	u+c;
    enddef;
    pair A,B;
    A:=(c,0u);
    B:=(c,7u);
    pickup pencircle xscaled sasx yscaled sasy;
    linejoin:=mitered;
enddef;

def crb(suffix i,j,val)=
    if x.i<x.j:
	if y.i<y.j:
	    ((x.i-x.j)/(y.i-y.j))*(x.i+x.j)*val,x.j+x.i
	fi
	if y.i>y.j:
	    ((x.i-x.j)/(y.i-y.j))*(x.i+x.j)*val,x.j+x.i
	fi
    fi
enddef;

def col=
    if visual>1:
	 withcolor .6white
    else:
    fi
enddef;

def spcharend(suffix n_points)=
pickup pencircle scaled 1;

if visual>=1:
    draw (-marg*ux,-2*uy)--((marg+chasse)*ux,-2*uy)--((marg+chasse)*ux,h+3u)--(-marg*ux,h+3u)-- cycle withcolor white;
    fi
    if visual>1:  
    pickup pencircle scaled 1.2
      for i=0 upto chasse:
        draw (i*ux,h)--(i*ux,0) withcolor blue;
    endfor
      for i=0 upto 7:
        draw (0*ux,i*uy)--(chasse*ux,i*uy) withcolor blue;
      endfor;

    defaultscale :=2.2;
    for i=1 upto n_points:
	dotlabels.top([i]);
    endfor;
fi
endfig
enddef;

def PVisual(suffix visual,i,j,k)=
  if visual>1:
    withcolor .6white;
  fi
enddef;

def gouache(suffix i, rot, opt)=
  
  Ysc:=sasy/curve; 
  
  if opt=refl:
  
    pickup pencircle xscaled sasx yscaled Ysc rotated rot;
    undraw z.i;
    pickup pencircle xscaled sasx yscaled Ysc rotated -rot;
    undraw z.i reflectedabout(A,B) rotated 0;
 
  elseif opt=sup:
    
    Xsc:=sasx*2;

    pickup pencircle xscaled Xsc yscaled Ysc rotated rot;
    undraw z.i shifted(0,sasy/2);
  
  elseif opt=doubl:
    
    Xsc:=sasx*2;

    pickup pencircle xscaled Xsc yscaled Ysc rotated rot;
    undraw z.i;
  
  else:

    pickup pencircle xscaled sasx yscaled Ysc rotated rot;
    undraw z.i;
  
  fi
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LES FONCTIONS DES COURBES. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def spirou_soft(suffix i,j) =
  if x.i<x.j:
    cutdraw z.i{val.u,x.j-x.i}
    ... z.j
  fi
  if x.i>x.j:
    cutdraw z.i{val.u,x.i-x.j}
    ... z.j
  fi
enddef;

def spirou_half(suffix i,j,k) =
 inco:=0;
 cutdraw z.i{inco,y.j-y.i}
 ... (val[x.j,x.i],val[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,inco}
 ... (val[x.j,x.k],val[y.k,y.j]){z.k-z.j}
 ... z.k{inco,y.k-y.j}
    col
enddef;

def spirou_crescent(suffix i,j,k) =
 inco:=0;
 draw z.i{x.j-x.i,inco}
  ... (val[x.i,x.j],val[y.j,y.i]){z.j-z.i}
  ... z.j{inco,y.k-y.i}
  ... (val[x.k,x.j],val[y.j,y.k]){z.k-z.j}
  ... z.k{x.k-x.j,inco}
    col
enddef;


def pen_form(expr type_pen) =
  pickup type_pen scaled sas;
enddef;

def diago (suffix i,j,deg)=
    sasxdia=sasx-.8u;
    sasydia=sasy-.8u;
    pickup pensquare xscaled sasxdia yscaled sasydia rotated deg;
    cutdraw z.i--z.j col;
enddef;
