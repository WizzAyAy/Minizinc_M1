include "alldifferent.mzn";
%include "configuration1.dzn";
%include "configuration2.dzn";
include "exempleRikudoFr.dzn";
%include "insatisfiable.dzn";

 % Rayon de l'exagone
int: rayon = 3;

% On décale toutes les cases de 1 : (0,0) -> (1,1)
set of int : x = 1..7;
set of int : y = 1..7;

% Rikudo 36 : matrice 7*7 _ 36 cases utiles _ 13 cases inutiles
array[x,y] of var -13..36: grilleIn;
array[x,y] of var -13..36: grille;

% Récupération des paramètres d'entrée
constraint forall(i, j in x)(
           if grilleIn[i,j] > 0
           then grille[i,j] = grilleIn[i,j]
           endif
           );

% Toutes les cases doivent être différentes
constraint forall (i in x, j in x) (
           alldifferent (grille)
           );

% Les cases utilisables doivent être > 0 _____ cases inutilisables < 0
constraint forall(i,j in x)(
           if ((i+j)>=5 /\ (i+j)<=11 /\ (i!=4 \/ j!=4)) % i+j >= 5
           then grille[i,j] > 0
           endif
           );

% Voisinage pour les cases utilisables (> 0) qui ne sont pas situées aux bordures de la matrice
constraint forall(i,j in x)(
           if (grille[i,j]>0 /\ grille[i,j]!=36 /\ (i!=1) /\ (i!=7) /\ (j!=1) /\ (j!=7)) then
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i-1,j]
           endif
           );

% Voisinage coin 1
constraint ( if grille[1,4]!=36 then
           grille[1,4]+1 = grille[1,5]     \/
           grille[1,4]+1 = grille[2,4]     \/
           grille[1,4]+1 = grille[2,3]
           endif
           );
           
% Voisinage coin 2
constraint ( if grille[1,7]!=36 then
           grille[1,7]+1 = grille[1,6]  \/
           grille[1,7]+1 = grille[2,6]  \/
           grille[1,7]+1 = grille[2,7]
           endif
           );
           
% Voisinage coin 3           
constraint ( if grille[4,7]!=36 then
           grille[4,7]+1 = grille[3,7]    \/
           grille[4,7]+1 = grille[4,6]    \/
           grille[4,7]+1 = grille[5,6]
           endif
           );
           
% Voisinage coin 4
constraint ( if grille[7,4] != 36 then
           grille[7,4]+1 = grille[6,5]    \/
           grille[7,4]+1 = grille[6,4]    \/
           grille[7,4]+1 = grille[7,3]
           endif
           );

% Voisinage coin 5
constraint ( if grille[7,1] != 36 then
           grille[7,1]+1 = grille[6,1]    \/
           grille[7,1]+1 = grille[6,2]    \/
           grille[7,1]+1 = grille[7,2]
           endif
           );

% Voisinage coin 6
constraint ( if grille[4,1] != 36 then
           grille[4,1]+1 = grille[3,2]    \/
           grille[4,1]+1 = grille[4,2]    \/
           grille[4,1]+1 = grille[5,1]
           endif
           );
           

% Voisinage pour les cases de la bordure supérieure gauche (- les coins)
constraint forall(i,j in x)(
           if (((i+j=5) /\ (i!=1 \/ j!= 4) /\ (i!=4 \/ j!=1)) /\ grille[i,j] != 36) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );

% Voisinage pour les cases de la bordure inférieure droite (- les coins)
constraint forall(i,j in x)(
           if (((i+j=11) /\ (i!=4 \/ j!=7) /\ (i!=7 \/ j!=4)) /\ grille[i,j] != 36) then 
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1]
           endif
           );

% Voisinage pour les cases de la bordure supérieure (- les coins)
constraint forall(i,j in x)(
           if((i=1 /\ (j>4 /\ j<7)) /\ grille[i,j] != 36) then 
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]   \/
           grille[i,j]+1 = grille[i,j+1]
           endif
           );

% Voisinage pour les cases de la bordure inférieure (- les coins)
constraint forall(i,j in x)(
           if ((i=7 /\ (j>1 /\ j<4)) /\ grille[i,j] != 36) then 
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]
           endif
           );

% Voisinage pour les cases de la bordure inférieure gauche (- les coins)
constraint forall(i,j in x)(
           if ((j=1 /\ (i<7 /\ i>4)) /\ grille[i,j] !=36) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i-1,j+1] \/
           grille[i,j]+1 = grille[i,j+1]   \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );
           
% Voisinage pour les cases de la bordure supérieure droite (- les coins)
constraint forall(i,j in x)(
           if((j=7 /\ (i>1 /\ i<4)) /\ grille[i,j] !=36) then 
           grille[i,j]+1 = grille[i-1,j]   \/
           grille[i,j]+1 = grille[i,j-1]   \/
           grille[i,j]+1 = grille[i+1,j-1] \/
           grille[i,j]+1 = grille[i+1,j]
           endif
           );
                                                                  
solve satisfy;

output["      | "++show_int(2,grille[1,4])++"| "++show_int(2,grille[1,5])++"| "++show_int(2,grille[1,6])++"| "++show_int(2,grille[1,7])++"| \n"];
output["     / \\ / \\ / \\ / \\ / \\ \n"];
      
output["    | "++show_int(2,grille[2,3])++"| "++show_int(2,grille[2,4])++"| "++show_int(2,grille[2,5])++"| "++show_int(2,grille[2,6])++"| "++show_int(2,grille[2,7])++"| \n"];
output["   / \\ / \\ / \\ / \\ / \\ / \\ \n"];
     
output["  | "++show_int(2,grille[3,2])++"| "++show_int(2,grille[3,3])++"| "++show_int(2,grille[3,4])++"| "++show_int(2,grille[3,5])++"| "++show_int(2,grille[3,6])++"| "++show_int(2,grille[3,7])++"| \n"];
output[" / \\ / \\ / \\ / \\ / \\ / \\ / \\ \n"];
     
output["| "++show_int(2,grille[4,1])++"| "++show_int(2,grille[4,2])++"| "++show_int(2,grille[4,3])++"| "++"X "++"| "++show(grille[4,5])++"| "++show_int(2,grille[4,6])++"| "++show_int(2,grille[4,7])++"| \n"];
output[" \\ / \\ / \\ / \\ / \\ / \\ / \\ / \n"];
output["  | "++show_int(2,grille[5,1])++"| "++show_int(2,grille[5,2])++"| "++show_int(2,grille[5,3])++"| "++show_int(2,grille[5,4])++"| "++show_int(2,grille[5,5])++"| "++show_int(2,grille[5,6])++"| \n"];
output["   \\ / \\ / \\ / \\ / \\ / \\ / \n"];
      
output["    | "++show_int(2,grille[6,1])++"| "++show_int(2,grille[6,2])++"| "++show_int(2,grille[6,3])++"| "++show_int(2,grille[6,4])++"| "++show_int(2,grille[6,5])++"| \n"];
output["     \\ / \\ / \\ / \\ / \\ / \n"];
      
output["      | "++show_int(2,grille[7,1])++"| "++show_int(2,grille[7,2])++"| "++show_int(2,grille[7,3])++"| "++show_int(2,grille[7,4])++"| \n"];