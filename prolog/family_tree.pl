father(bob, carl).
father(bob, eve).
father(carl, dave).
mother(alice, carl).
mother(alice, eve).

male(bob).
male(carl).
male(dave).

female(alice).
female(eve).

parent(Parent, Child):-
    father(Parent, Child).
parent(Parent, Child):-
    mother(Parent, Child).

son(Person):-
    male(Person),
    parent(_, Person).

daughter(Person):-
    female(Person),
    parent(_, Person).

grandparent(G, C):-
    parent(G, P),
    parent(P, C).
