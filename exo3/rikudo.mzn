include "alldifferent.mzn";
include "configuration1.dzn";

/*____________________________________________________________________

int : nbrTotalCases = ((rayon*2)+1 * (rayon*2)+1)
------
int somme
Boucle i=1 to i=rayon
somme = somme + ((rayon*2)-i)+1
------
int : nbrCasesUtiles = (somme*2)+(rayon*2)
int : nbrCasesInutiles = nbrTotalCases - nbrCasesUtiles

Borne inférieure = nbrCasesInutiles
Borne supérieure = nbrCasesUtiles

array[x,y] of var nbrCasesInutiles..nbrCasesUtiles : grilleIn
array[x,y] of var nbrCasesInutiles..nbrCasesUtiles : grille
______________________________________________________________________*/

int: rayon;

% On décale toutes les cases de 1 : (0,0) -> (1,1)
set of int : x = 1..(rayon*2)+1;
set of int : y = 1..(rayon*2)+1;

% _____________ grilleIn ______________
% [valeur négative] : cases inutiles
% [0] : case à remplir par MiniZinc
% [valeur positive] : valeur de la case
% _____________________________________

% Rikudo 36 : matrice 7*7 ___ 36 cases utiles ___ 13 cases inutiles
array[x,y] of var -13..36: grilleIn;
array[x,y] of var -13..36: grille;

constraint forall(i, j in x)(
           if grilleIn[i,j] > 0
           then grille[i,j] = grilleIn[i,j]
           endif
           );

% Toutes les cases doivent être différentes
constraint forall (i in x, j in x) (
           alldifferent (grille)
           );

% Les cases utiles doivent être > 0 _____ cases inutiles < 0
constraint forall(i,j in x)(
           if (i+j>=rayon+2 /\ i+j<=(rayon*3)+2 /\ (i!=rayon+1 \/ j!=rayon+1))
           then grille[i,j] > 0
           endif
           );

/*

 Coin 1 __ Coin 2 
Coin 6 /  \ Coinc 3
       \__/
 Coin 5    Coin 4 
 
*/

% Voisinage coin 1
constraint forall(i,j in x)(
           if(i=1 /\ j=rayon+1) then 
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );
           
% Voisinage coin 2
constraint forall(i,j in x)(
           if(i=1 /\ j=(rayon*2)+1) then 
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );
           
% Voisinage coin 3
constraint forall(i,j in x)(
           if(i=rayon+1 /\ j=(rayon*2)+1) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );
           
% Voisinage coin 4
constraint forall(i,j in x)(
           if(i=(rayon*2)+1 /\ j=rayon+1) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]
           endif
           );

% Voisinage coin 5
constraint forall(i,j in x)(
           if(i=(rayon*2)+1 /\ j=1) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]
           endif
           );

% Voisinage coin 6
constraint forall(i,j in x)(
           if(i=rayon+1 /\ j=1) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );
           
% Voisinage pour les cases utiles (> 0) qui ne sont pas situées aux bordures de la matrice
constraint forall(i,j in x)(
           if (grille[i,j]>0 /\ (i!=1) /\ (i!=(rayon*2)+1) /\ (j!=1) /\ (j!=(rayon*2)+1)) then
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i-1,j]
           endif
           );

% Voisinage pour les cases de la bordure nord-ouest (- les coins)
constraint forall(i,j in x)(
           if((i+j=rayon+2) /\ (i!=1 \/ j!= rayon+1) /\ (i!=rayon+1 \/ j!=1)) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );

% Voisinage pour les cases de la bordure sud-est (- les coins)
constraint forall(i,j in x)(
           if((i+j=(rayon*3)+2) /\ (i!=rayon+1 \/ j!= (rayon*2)+1) /\ (i!=(rayon*2)+1 \/ j!=rayon+1)) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );

% Voisinage pour les cases de la bordure nord (- les coins)
constraint forall(i,j in x)(
           if(i=1 /\ (j>rayon+1 /\ j<(rayon*2)+1)) then 
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i,j+1]
           endif
           );

% Voisinage pour les cases de la bordure sud (- les coins)
constraint forall(i,j in x)(
           if(i=(rayon*2)+1 /\ (j>1 /\ j<rayon+1)) then 
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]
           endif
           );

% Voisinage pour les cases de la bordure ouest (- les coins)
constraint forall(i,j in x)(
           if(j=1 /\ (i<(rayon*2)+1 /\ j>rayon+1)) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );
           
% Voisinage pour les cases de la bordure est (- les coins)
/*constraint forall(i,j in x)(
           if(j=(rayon*2)+1 /\ (i>1 /\ j<rayon+1)) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );*/
                                                                  
%solve satisfy;

output[
        show2d(grille)
      ];