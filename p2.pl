/*format for node
	node(int,LST,RST)
	int will > 0
	No duplicate ints in a tree
*/

tree(1,tree(empty),tree(empty)).
tree(5,tree(3,tree(2,tree(empty),tree(empty)),tree(4,tree(empty),tree(empty))),tree(8,tree(7,tree(empty),tree(empty)),tree(9,tree(empty),tree(10,tree(empty),tree(empty))))).

/* help/0
Displays to the terminal the proper tree input format and a
list of all predicates/arity available. */
help :- write('Proper tree input: node(num,LeftSubtree,RightSubtree)'),
	   nl,write('Predicates: ').

/* isEmpty/1 
Argument is a BST. Succeeds if the tree is empty. */

isEmpty(tree(empty)).

/* inverts ouotput of previous */
isNotEmpty(X) :- \+ (isEmpty(X)).

/* preOrderDisplay/1
Argument is a BST. Visits the tree nodes in preorder 
recursively and displays its data to the terminal.*/
preOrderDisplay(tree(R,LST,RST)) :- isNotEmpty(tree(R,LST,RST)),integer(R),write(R),write(' '),preOrderDisplay(LST),preOrderDisplay(RST).
preOrderDisplay(tree(empty)).

/*inOrderDisplay
Argument is a BST. Visits the tree nodes in inorder 
recursively and displays its data to the terminal. */
inOrderDisplay(tree(R,LST,RST)) :- isNotEmpty(tree(R,LST,RST)),integer(R),inOrderDisplay(LST),write(R),write(' '),inOrderDisplay(RST).
inOrderDisplay(tree(empty)). 

/*postOrderDisplay/1
Argument is a BST. Visits the tree nodes in inorder 
recursively and displays its data to the terminal. */
postOrderDisplay(tree(R,LST,RST)) :- isNotEmpty(tree(R,LST,RST)),integer(R),postOrderDisplay(LST),postOrderDisplay(RST),write(R),write(' ').
postOrderDisplay(tree(empty)).

/*preOrderWrite/2
First argument is a BST and the second argument is a file 
name. Visits the tree nodes in preorder recursively and writes 
its data to the file separated by spaces.*/
preOrderWrite(tree(R,LST,RST),Filename) :- tell(Filename), preOrderDisplay(tree(R,LST,RST)),told.

/*inOrderWrite/2
First argument is a BST and the second argument is a file 
name. Visits the tree nodes in inorder recursively and writes 
its data to the file separated by spaces. */
inOrderWrite(tree(R,LST,RST),Filename) :- tell(Filename), inOrderDisplay(tree(R,LST,RST)),told.

/*postOrderWrite/2
First argument is a BST and the second argument is a file 
name. Visits the tree nodes in postorder recursively and writes 
its data to the file separated by spaces. */
postOrderWrite(tree(R,LST,RST),Filename) :- tell(Filename), postOrderDisplay(tree(R,LST,RST)), told.


/*If item is greater than root*/
insert(tree(Root,Left,Right),X,R) :- X > Root,insert(Right,X,R1),R = tree(Root,Left,R1).
/*If item is less than root*/
insert(tree(Root,Left,Right),X,R) :- X < Root,insert(Left,X,R1),R = tree(Root,R1,Right). 
/*If item is already in tree*/
insert((Root,Left,Right),Root,(Root,Left,Right)).
/*Spot to enter has been found*/
insert(tree(empty),X,tree(X,tree(empty),tree(empty))).

/* Opens the file, creates an empty tree, recursively grows the tree from the file, closes file */
treeRead(Filename, R) :- see(Filename), BST = tree(empty), getTree(BST, R), seen.
/* get next character, process character*/
getTree(BST, R) :- get(X), processTree(X, BST,R).
/* if X is not the end of file, insert the true value of X, get next character */
processTree(X, BST, R) :- X \= -1, X1 is X - 48, insert(BST, X1, R1), getTree(R1,R).
/* End of file, return current tree progress */
processTree(-1, BST, BST).

/* checks if there is an available left subtree, if not -> Root is min */
getMin(tree(empty),-1).
getMin(tree(_,Left,_),R) :- isNotEmpty(Left), getMin(Left,R).
getMin(tree(Root,tree(empty),_),R) :- write(Root), R = Root.

/* checks if there is an available right subtree, if not -> Root is max */
getMax(tree(empty),-1).
getMax(tree(_,_,Right),R) :- isNotEmpty(Right), getMax(Right,R).
getMax(tree(Root,_,tree(empty)),R) :- R = Root.