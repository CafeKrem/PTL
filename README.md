# PTL , Still in developement.
 Pharo transformation Language is a transformation model language like ALT tefkat.

## state of the project , in developement

For now there is only a pattern matching implemented.

## how to use it as a client 

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

### how to write pattern

#### LiteralMatcher 
we can match some Literal: 

##### numberMatcher  

```smalltalk 
stringMatcher := 100 asMatcher. 
stringMatcher2 := PTLMatcherInteger named: #int asMatcher. 
(stringMatcher match: 100) isMatch. "true"
(stringMatcher match: 50) isMatch. "false"
(stringMatcher2 match: 200) at: #int. "200"
```

##### StringMatcher

```smalltalk 
stringMatcher := 'klm' asMatcher. 
stringMatcher2 := PTLMatcherString named: #int asMatcher. 
(stringMatcher match: 'klm') isMatch. "true"
(stringMatcher match: 'patrick') isMatch. "false"
(stringMatcher2 match: 'anything') at: #int. "anything"
```

#### match a compose String

```smalltalk
pattern := { 'set' , #*aName}.
(pattern match: 'setLabel') at: #aName. "Label"
```
#* this match a collection of ellement.
#* it's equivalent to a kleen star.

```smalltalk
pattern := {$@first . $* . $@last }.
matchResult := pattern match: {1 .2 .3 .4 .5 .6}.
matchResult at: #first."1"
matchResult at: #last. "6"
```
$@aName will store only one element.


## how to use it as maintener




