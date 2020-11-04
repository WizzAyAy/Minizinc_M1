include "garamDataHardExemple.dzn";

% les lignes du garam
set of int : nbLigne = 1..9;

%l es colonnes du garam
set of int : nbColonne = 1..7;

% [1..9] les valeurs des cases
% [0]    on chercher la valeur de cette case
% [-1]   cette case est vide 

% la matrice (lico) des valeurs en "dur" donné par l'utilisateur
array[nbLigne, nbColonne] of var -1..9: garamEntry;

% la matrice (lico) des variables c'est cette matrice qu'on affiche
array[nbLigne, nbColonne] of var 0..9: garam;

% on a 20 operations 1=+ 2=- 3=*
% tab des opes juste pour que ca soit plus pratique
set of int : nbOpe = 1..20;
array[nbOpe] of var 1..3: ope;

% 1 on remplit notre garam avec les valeurs mis en entré du programe
constraint forall(i, j in nbLigne)(if  j < 8  /\ garamEntry[i,j] > 0 then garam[i,j] = garamEntry[i,j] endif);

% 2 on met toutes les constraints avec toutes les operations
% sans ces constraints 
constraint garam[3,1] > 0;
constraint garam[3,3] > 0;
constraint garam[3,5] > 0;
constraint garam[3,7] > 0;

constraint garam[8,1] > 0;
constraint garam[8,3] > 0;
constraint garam[8,5] > 0;
constraint garam[8,7] > 0;

constraint if ope[1] == 1 then garam[1,3] = garam[1,1] + garam[1,2] endif;
constraint if ope[1] == 2 then garam[1,3] = garam[1,1] - garam[1,2] endif;
constraint if ope[1] == 3 then garam[1,3] = garam[1,1] * garam[1,2] endif;

constraint if ope[2] == 1 then garam[1,7] = garam[1,5] + garam[1,6] endif;
constraint if ope[2] == 2 then garam[1,7] = garam[1,5] - garam[1,6] endif;
constraint if ope[2] == 3 then garam[1,7] = garam[1,5] * garam[1,6] endif;

constraint if ope[3] == 1 then garam[3,1] * 10 + garam[4,1] = garam[1,1] + garam[2,1] endif;
constraint if ope[3] == 2 then garam[3,1] * 10 + garam[4,1] = garam[1,1] - garam[2,1] endif;
constraint if ope[3] == 3 then garam[3,1] * 10 + garam[4,1] = garam[1,1] * garam[2,1] endif;

constraint if ope[4] == 1 then garam[3,3] * 10 + garam[4,3] = garam[1,3] + garam[2,3] endif;
constraint if ope[4] == 2 then garam[3,3] * 10 + garam[4,3] = garam[1,3] - garam[2,3] endif;
constraint if ope[4] == 3 then garam[3,3] * 10 + garam[4,3] = garam[1,3] * garam[2,3] endif;

constraint if ope[5] == 1 then garam[3,5] * 10 + garam[4,5] = garam[1,5] + garam[2,5] endif;
constraint if ope[5] == 2 then garam[3,5] * 10 + garam[4,5] = garam[1,5] - garam[2,5] endif;
constraint if ope[5] == 3 then garam[3,5] * 10 + garam[4,5] = garam[1,5] * garam[2,5] endif;

constraint if ope[6] == 1 then garam[3,7] * 10 + garam[4,7] = garam[1,7] + garam[2,7] endif;
constraint if ope[6] == 2 then garam[3,7] * 10 + garam[4,7] = garam[1,7] - garam[2,7] endif;
constraint if ope[6] == 3 then garam[3,7] * 10 + garam[4,7] = garam[1,7] * garam[2,7] endif;

constraint if ope[7] == 1 then garam[2,5] = garam[2,3] + garam[2,4] endif;
constraint if ope[7] == 2 then garam[2,5] = garam[2,3] - garam[2,4] endif;
constraint if ope[7] == 3 then garam[2,5] = garam[2,3] * garam[2,4] endif;

constraint if ope[8] == 1 then garam[4,3] = garam[4,1] + garam[4,2] endif;
constraint if ope[8] == 2 then garam[4,3] = garam[4,1] - garam[4,2] endif;
constraint if ope[8] == 3 then garam[4,3] = garam[4,1] * garam[4,2] endif;

constraint if ope[9] == 1 then garam[4,7] = garam[4,5] + garam[4,6] endif;
constraint if ope[9] == 2 then garam[4,7] = garam[4,5] - garam[4,6] endif;
constraint if ope[9] == 3 then garam[4,7] = garam[4,5] * garam[4,6] endif;

constraint if ope[10] == 1 then garam[6,2] = garam[4,2] + garam[5,2] endif;
constraint if ope[10] == 2 then garam[6,2] = garam[4,2] - garam[5,2] endif;
constraint if ope[10] == 3 then garam[6,2] = garam[4,2] * garam[5,2] endif;

constraint if ope[11] == 1 then garam[6,6] = garam[4,6] + garam[5,6] endif;
constraint if ope[11] == 2 then garam[6,6] = garam[4,6] - garam[5,6] endif;
constraint if ope[11] == 3 then garam[6,6] = garam[4,6] * garam[5,6] endif;

constraint if ope[12] == 1 then garam[6,3] = garam[6,1] + garam[6,2] endif;
constraint if ope[12] == 2 then garam[6,3] = garam[6,1] - garam[6,2] endif;
constraint if ope[12] == 3 then garam[6,3] = garam[6,1] * garam[6,2] endif;

constraint if ope[13] == 1 then garam[6,7] = garam[6,5] + garam[6,6] endif;
constraint if ope[13] == 2 then garam[6,7] = garam[6,5] - garam[6,6] endif;
constraint if ope[13] == 3 then garam[6,7] = garam[6,5] * garam[6,6] endif;

constraint if ope[14] == 1 then garam[8,1] * 10 + garam[9,1] = garam[6,1] + garam[7,1] endif;
constraint if ope[14] == 2 then garam[8,1] * 10 + garam[9,1] = garam[6,1] - garam[7,1] endif;
constraint if ope[14] == 3 then garam[8,1] * 10 + garam[9,1] = garam[6,1] * garam[7,1] endif;

constraint if ope[15] == 1 then garam[8,3] * 10 + garam[9,3] = garam[6,3] + garam[7,3] endif;
constraint if ope[15] == 2 then garam[8,3] * 10 + garam[9,3] = garam[6,3] - garam[7,3] endif;
constraint if ope[15] == 3 then garam[8,3] * 10 + garam[9,3] = garam[6,3] * garam[7,3] endif;

constraint if ope[16] == 1 then garam[8,5] * 10 + garam[9,5] = garam[6,5] + garam[7,5] endif;
constraint if ope[16] == 2 then garam[8,5] * 10 + garam[9,5] = garam[6,5] - garam[7,5] endif;
constraint if ope[16] == 3 then garam[8,5] * 10 + garam[9,5] = garam[6,5] * garam[7,5] endif;

constraint if ope[17] == 1 then garam[8,7] * 10 + garam[9,7] = garam[6,7] + garam[7,7] endif;
constraint if ope[17] == 2 then garam[8,7] * 10 + garam[9,7] = garam[6,7] - garam[7,7] endif;
constraint if ope[17] == 3 then garam[8,7] * 10 + garam[9,7] = garam[6,7] * garam[7,7] endif;

constraint if ope[18] == 1 then garam[7,5] = garam[7,3] + garam[7,4] endif;
constraint if ope[18] == 2 then garam[7,5] = garam[7,3] - garam[7,4] endif;
constraint if ope[18] == 3 then garam[7,5] = garam[7,3] * garam[7,4] endif;

constraint if ope[19] == 1 then garam[9,3] = garam[9,1] + garam[9,2] endif;
constraint if ope[19] == 2 then garam[9,3] = garam[9,1] - garam[9,2] endif;
constraint if ope[19] == 3 then garam[9,3] = garam[9,1] * garam[9,2] endif;

constraint if ope[20] == 1 then garam[9,7] = garam[9,5] + garam[9,6] endif;
constraint if ope[20] == 2 then garam[9,7] = garam[9,5] - garam[9,6] endif;
constraint if ope[20] == 3 then garam[9,7] = garam[9,5] * garam[9,6] endif;

solve satisfy;

%retour a la ligne toutes les l iterations
int: l = 7;
output [ show_float(3, 0, garam[i,j]) ++ 
         if j == l then "\n" else " " endif |
         i in nbLigne, j in nbColonne];