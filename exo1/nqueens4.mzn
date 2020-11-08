int: n;
% Boolean model:
% Map each position i,j to a Boolean telling us whether there is a queen at i,j
array[1..n,1..n] of var bool: qb;

% distinct rows
constraint forall(i in 1..n) 
            (
              sum(j in 1..n) (
                bool2int(qb[i,j])
              ) = 1
            )  ;
 

% distinct columns
constraint forall(j in 1..n) 
            (
              sum(i in 1..n) (
                bool2int(qb[i,j])
              ) = 1
            )  ;


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

% Inspiré de MiniZinc Handbook (Documentation de MiniZinc)
% Lexicographic symmetry breaking constraints
include "lex_lesseq.mzn";
constraint
    lex_lesseq(array1d(qb), [ qb[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ])
;
% search
solve :: bool_search(qb, first_fail, indomain_min)
      satisfy;
output [ if fix(qb[i,j]) == true then "Q" else "." endif ++
         if j == n then "\n" else "" endif | i,j in 1..n]