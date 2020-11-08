int: n;
array [1..n] of var 1..n: q; % queen in column i is in row q[i]


constraint forall(i,j in 1..n where i!=j) (  % distinct rows
                q[i]!=q[j]
           );
           
constraint forall(i,j in 1..n where i!=j) (  % distinct diagonals
                q[i] + i != q[j] + j
           );
           
constraint forall(i,j in 1..n where i!=j) (  % distinct upwards+downwards
                q[i] - i != q[j] - j
           );          


% search
solve :: int_search(q, input_order, indomain_min)
      satisfy;
output [ if fix(q[j]) == i then "Q" else "." endif ++
         if j == n then "\n" else "" endif | i,j in 1..n]
