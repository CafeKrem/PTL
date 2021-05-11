# PTL  ![https://github.com/CafeKrem/PTL/workflows/CI/badge.svg](https://github.com/CafeKrem/PTL/workflows/CI/badge.svg)[![Coverage Status](https://coveralls.io/repos/github/CafeKrem/PTL/badge.svg?branch=main)](https://coveralls.io/github/CafeKrem/PTL?branch=main)
 Pharo transformation Language is a transformation model language like ALT tefkat.

## state of the project , in developement

For now there is only a pattern matching implemented.

## how to use it as a client 



### install it

execute this.
```smalltalk
Metacello
	new
		repository: 'github://CafeKrem/PTL:main';
		baseline: 'PTL';
		onConflictUseIncoming;
		load.
```

### how to write pattern

#### LiteralMatcher 
we can match some Literal: 

##### numberMatcher  

```smalltalk 
stringMatcher := 100 asMatcher. 
stringMatcher2 := PTLMatcherInteger named: #int asMatcher. 
(stringMatcher match: 100) isMatch. "true"
(stringMatcher match: 50) isMatch. "false"
(stringMatcher2 match: 200) at: #int. "200"
```

##### StringMatcher

```smalltalk 
stringMatcher := 'klm' asMatcher. 
stringMatcher2 := PTLMatcherString named: #str asMatcher. 
(stringMatcher match: 'klm') isMatch. "true"
(stringMatcher match: 'patrick') isMatch. "false"
(stringMatcher2 match: 'anything') at: #str. "anything"
```

#### match a compose String

```smalltalk
pattern := { 'set' , #'*aName'} asMatcher.
(pattern match: 'setLabel') at: #aName. "Label"
```
#* this match a collection of ellement.
#* it's equivalent to a kleen star.

```smalltalk
pattern := {#'@first' . #'*' . #'@last' } asMatcher.
matchResult := pattern match: {1 .2 .3 .4 .5 .6}.
matchResult at: #first."1"
matchResult at: #last. "6"
```
#@aName will store only one element.


#### match an Object or an element of your model. 

```smalltalk
pattern := { (RBSequenceNode suchAs: { (#statements -> { 
			             (RBAssignmentNode suchAs: { (#variable -> #'@x') }).
			             (RBAssignmentNode suchAs: { (#variable -> #'@y') }).
			             ((RBMessageNode suchAs: { 
					               (#receiver -> #'@x').
					               (#arguments -> #'@y') }) named: #message) }) }) }
		           asMatcher.
	rbAST := RBParser parseExpression: 'a := 5. b:= 5. a + b'.
	matchResult := pattern match: rbAST.
	matchResult isMatch. "true"
	matchResult at: #x. "RBAssignementNode ..."
	matchResult at: #y ."RBAssignementNode ..."
	matchResult at: #message.
```
so to summarize , in order to write pattern matching on Object/element of your metaModel. 
you have to write something like this. 

```smalltalk
pattern := {MyObject suchAs: {#attribut1 -> "ShouldBeLike" MyObjectB } } asMatcher
```

and in `'a := 5. b:= 5. a + b'` expression there is another concept in our pattern. 
it's the fact that we can express that we want to match element that we matched. 

```smalltalk
(RBMessageNode suchAs: { 
	(#receiver -> #'@x').
	(#arguments -> #'@y') }) named: #message) })
```

in this part , there is **#'@x'** and **#'@y'** **x** and **y**  are already used in asignementNode.
Thanks to this it will only match if the value matched in **x** and **y** are equals to the current node. 




## how to use it as maintener




