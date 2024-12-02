% ---------- FACTS ----------

% Biological parents
biological_parent(widow, redhair).
biological_parent(widow, baby).
biological_parent(i, baby).
biological_parent(dad, i).
biological_parent(dad, son_run).
biological_parent(redhair, son_run).

% Spouses
spouse(i, widow).
spouse(widow, i).
spouse(dad, redhair).
spouse(redhair, dad).

% ---------- RULES ----------

% Parent relationships
parent(X, Y) :- biological_parent(X, Y).
parent(X, Y) :- step_parent(X, Y).

% Step-parent relationships
step_parent(X, Y) :-
    spouse(X, Z),
    biological_parent(Z, Y),
    \+ biological_parent(X, Y).

% Grandparent relationships
grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).

% Grandchild relationships
grandchild(X, Y) :-
    grandparent(Y, X).

% Sibling relationships
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% Son-in-law relationships
son_in_law(X, Y) :-
    spouse(X, Z),
    parent(Y, Z),
    X \= Y.

% Uncle and aunt relationships
uncle_aunt(X, Z) :-
    sibling(X, Y),
    parent(Y, Z).

% ---------- RUNIT ----------
runIt :-
    write('Is redhair the daughter of i ?: '),
    (parent(i, redhair) -> write('true'); write('false')), nl,
    write('Is redhair the mother of i ?: '),
    (parent(redhair, i) -> write('true'); write('false')), nl,
    write('Is dad the son in law of i ?: '),
    (son_in_law(dad, i) -> write('true'); write('false')), nl,
    write('Is baby the brother of dad ?: '),
    (sibling(baby, dad) -> write('true'); write('false')), nl,
    write('Is baby the uncle of i ?: '),
    (uncle_aunt(baby, i) -> write('true'); write('false')), nl,
    write('Is baby the brother of redhair ?: '),
    (sibling(baby, redhair) -> write('true'); write('false')), nl,
    write('Is son_run the grandchild of i ?: '),
    (grandchild(son_run, i) -> write('true'); write('false')), nl,
    write('Is widow the mother of redhair?: '),
    (parent(widow, redhair) -> write('true'); write('false')), nl,
    write('Is widow the grandmother of i ?: '),
    (grandparent(widow, i) -> write('true'); write('false')), nl,
    write('Is i the grandchild of widow ?: '),
    (grandchild(i, widow) -> write('true'); write('false')), nl,
    write('Is i the grandfather of i ?: '),
    (grandparent(i, i) -> write('true'); write('false')), nl,
    write('Is i his own grandfather ?: '),
    (grandparent(i, i) -> write('true'); write('false')), nl.
