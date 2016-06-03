outputtemplate := "%j%c.svg"; % exporter en svg.

%UNITE DE VALEUR
u:=40pt;

%CHASSE-X
ux:=3u;

%HAUTEUR DE CORPS
uy:=3u;
h:=7uy;

%GRAISSE / PLEINS ET DELIEES 
sas:=3u; %GRAISSE
sasx:=1sas; %GRAISSE X
sasy:=.9sas; %GRAISSE Y
ho:=h-(sasy/2); 
bo:=sasy/2;

%TRAVERSE
barheight:=h/2;

%COURBE
val:=.84;
fleche:=0;

%TENSION
tens:=.1;

%VISUALISATION
visual:=1; %0=Brut 1=Avec Chasse 2=Avec Chasse + Grille 
marg:=1; %Marg en X

%LES INPUT
input def


	
defaultscale:=.2;
