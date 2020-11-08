int: n;
% Boolean model:
% Map each position i,j to a Boolean telling us whether there is a queen at i,j
array[1..n,1..n] of var bool: qb;

constraint forall(j in 1..n) 
            (
              sum(i in 1..n) (
                bool2int(qb[i,j])
              ) = 1
            )  ;

constraint forall(i in 1..n) 
            (
              sum(j in 1..n) (
                bool2int(qb[i,j])
              ) = 1
            )  ;
 
 %http://docs.optano.net/modeling/current/userDoc/model_examples/ips/queens/queens_introduction.html
 % distinct upgrades + downgrades
constraint forall(i, j in 1..n)(
	qb[i,j] = not (
		exists(j1 in 1..n where j1 != j)(qb[i,j1])
	\/	exists(i1 in 1..n where i1 != i)(qb[i1,j])
	\/	exists(k in 1..n)(
			qb[i+k,j+k] \/ qb[i-k,j+k]
	    \/	qb[i+k,j-k] \/ qb[i-k,j-k]
		)
	)
);
% search
solve :: bool_search(qb, first_fail, indomain_min)
      satisfy;
output [ if fix(qb[i,j]) == true then "Q" else "." endif ++
         if j == n then "\n" else "" endif | i,j in 1..n]