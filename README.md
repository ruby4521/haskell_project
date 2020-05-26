# Fan Tan Game
## Project goal:
My idea is to make a “Fan Tan” or “Sevens” poker card game. First, it will have two or four players in the game. Then each person will be given the same numbers of card. The player with the diamond seven will have to be first and put it in the middle. There will be three cases for the next player. The next player will give the number, which is previous or following to diamond seven, or the player will give another seven, or else the player will be passed to the next player. The one who first give out all of cards will be the winner.

## Current Progress:
I implement the shuffle-a-deck-of-cards function by getting a deck of cards in a random sequence. I'm still trying to figure out how am I going to implement the get-cards-from-a-random-deck action whether I should possible implement it with a state stack like monad which contains pop and push like function or something else. 

## How to run the file:
Since I haven't do the implementation in `Main.hs`, please go to the `src/` directory and run `Card.hs` file by typing `stack ghci Card.hs`

If you haven't, you might have to install some of the packages like "System.Random", "Control.Monad.Random", "System.Random.Shuffle"

If you see the error message saying `Could not find module ‘System.Random’`, try run `stack install random`.

If you see the error message saying `Could not find module ‘Control.Monad.Random’`, try run `stack install MonadRandom`. 

If you see the error message saying `Could not find module ‘System.Random.Shuffle’`, try run `stack install random-shuffle`. 

After installing those packages, run `stack ghci Card.hs` again.


## Some input:
Below are some input functions that I currently implement.

-- Check the content of the all cards value including its rank and suit

` >>> allCards `

`[PlayingCards Ace Hearts,Card Ace Diamonds ... , PlayingCards King Clubs] `

-- Check the content of all cards suits

` >>> allSuits`

`[Hearts,Diamonds,Spades,Clubs]`
 
-- Check the content of all cards ranks

`>>> allRanks`

`[Ace,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King]`

-- Get the rank of the card

`>>> getRank (PlayingCards Ace Hearts) `

`Ace`

-- Get the suit of the card

`>>> getSuit (PlayingCards Ace Hearts)`

`Hearts`

-- Compare the suit and return true or false 

`>>> compareSuit Hearts Clubs`

`False`

`>>> compareSuit Hearts Hearts`

`True`

-- Compare the rank and return GT, EQ or LT

`>>> compareRank Ace King`

`LT`

`>>> compareRank King Ace`

`GT`

`>>> compareRank King King`

`EQ`

-- Roll the dice to decide the order of the player (print random number in range 1 to 4)

`>>> rollDice`

`1`

`>>> rollDice`

`3`

-- Get a random shuffled deck 
`>>> deck <- evalRandIO $ shuffle $ allCards`

`>>> deck`

`[PlayingCards Three Clubs,PlayingCards Two Diamonds, ..., PlayingCards Four Clubs,PlayingCards Eight Hearts]`

-- Player1 gets seven cards from that deck
`>>> player1Get 0 6 deck `

`[PlayingCards Three Clubs,PlayingCards Two Diamonds,PlayingCards Nine Spades,PlayingCards Six Spades,PlayingCards King Spades,PlayingCards Seven Clubs,PlayingCards King Diamonds]`

-- Player2 gets seven cards from that deck
`>>> player2Get 7 13 deck`

`[PlayingCards Ace Diamonds,PlayingCards Ace Hearts,PlayingCards Ten Clubs,PlayingCards Five Diamonds,PlayingCards Ten Hearts,PlayingCards Five Hearts,PlayingCards Five Spades]`

-- Player3 gets seven cards from that deck
`>>> player3Get 14 20 deck`

`[PlayingCards Nine Clubs,PlayingCards Three Hearts,PlayingCards Four Spades,PlayingCards Seven Hearts,PlayingCards Ace Clubs,PlayingCards Ten Spades,PlayingCards Queen Spades]`

-- Player4 gets seven cards from that deck
`>>> player4Get 21 27 deck`

`[PlayingCards Five Clubs,PlayingCards Six Hearts,PlayingCards Eight Spades,PlayingCards Nine Hearts,PlayingCards Queen Clubs,PlayingCards Two Hearts,PlayingCards Eight Clubs]`

## Design questions
1. Is it better to implement the get-cards-from-deck action with state monad? Or other thoughts on implementing these kind of actions?
2. Any comment about my current implementation?
