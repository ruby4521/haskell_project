# Fan Tan Game
## Project goal (from proposal):
My idea is to make a “Fan Tan” or “Sevens” poker card game. First, it will have two or four players in the game. Then each person will be given the same numbers of card. The player with the diamond seven will have to be first and put it in the middle. There will be three cases for the next player. The next player will give the number, which is previous or following to diamond seven, or the player will give another seven, or else the player will be passed to the next player. The one who first give out all of cards will be the winner.

## Current Progress:
I have some of the initial data type of the card value including its suit rank and some basic function to get the card value. These functions may be used in the following advanced functions. In the game, I'm planning to implement a function to get a random card. However, I have some problem getting it right. 

## How to run the file:
You should be able to run the file by running `stack build` in the root directory then run `stack exec my-project-exe`. If you haven't, you might have to install some of the packages like "System.Random", "Control.Monad.Random", "System.Random.Shuffle"

If you see the error message saying `Could not find module ‘System.Random’`, try run `stack install random`.

If you see the error message saying `Could not find module ‘Control.Monad.Random’`, try run `stack install MonadRandom`. 

If you see the error message saying `Could not find module ‘System.Random.Shuffle’`, try run `stack install random-shuffle`. 



## Some input:
allCards -> to check the content of the all cards value including its rank and suit

` >>> allCards `

`[Card Ace Hearts,Card Ace Diamonds ... ,Card King Clubs] `

allSuits -> to check the content of all cards suits

` >>> allSuits`

`[Hearts,Diamonds,Spades,Clubs]`
 
allRanks -> to check the content of all cards ranks

`>>> allRanks`

`[Ace,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King]`

getRank -> to get the rank of the card

`>>> getRank (Card Ace Hearts) `

`Ace`

getSuit -> to get the suit of the card

`>>> getSuit (Card Ace Hearts)`

`Hearts`

compareSuit -> compare the suit and return true or false 

`>>> compareSuit Hearts Clubs`

`False`

`>>> compareSuit Hearts Hearts`

`True`

compareRank -> compare the rank and return GT, EQ or LT

`>>> compareRank Ace King`

`LT`

`>>> compareRank King Ace`

`GT`

`>>> compareRank King King`

`EQ`

rollDice -> roll the dice to decide the order of the player (print random number in range 1 to 4)

`>>> rollDice`

`1`

`>>> rollDice`

`3`

## Design questions
1. Any idea about implementing a random deck of cards?
2. Any comment about my current implementation?
