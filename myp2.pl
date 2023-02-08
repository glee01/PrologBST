/*format for node
	node(int,LST,RST)
	int will > 0
	No duplicate ints in a tree
*/

tree(5,tree(empty),tree(empty)).

/* help/0
Displays to the terminal the proper tree input format and a
list of all predicates/arity available. */
help :- write('Proper tree input: node(num,LeftSubtree,RightSubtree)'),
	   nl,write('Predicates: ').


/* isEmpty/1 
Argument is a BST. Succeeds if the tree is empty. */

isEmpty(tree(empty)).

preOrderDisplay(tree(R,LST,RST)) :- integer(R),write(R),preOrderDisplay(LST),preOrderDisplay(RST).

/*If item is greater than root*/
insert(tree(Root,Left,Right),X,R) :- X > Root,insert(Right,X,R1),R = tree(Root,Left,R1).
insert(tree(empty),X,tree(X,tree(empty),tree(empty))). 
/*If item is already in tree*/
insert((Root,Left,Right),Root,(Root,Left,Right)).