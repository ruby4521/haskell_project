# Fan Tan Game
## How to run the file:
The program will be run by `stack`. If you haven't, you can go to `https://docs.haskellstack.org/en/stable/README/` for more detail on installing `stack`.

Some libraries that this program depends on are `System.Random`, `Control.Monad.Random` and `System.Random.Shuffle`

Please go to the `code/` directory and compile the `Game.hs` file by running `stack ghci Game.hs `

If you haven't, you might have to install some of the packages like "System.Random", "Control.Monad.Random", "System.Random.Shuffle"

If you see the error message saying `Could not find module ‘System.Random’`, try run `stack install random`.

If you see the error message saying `Could not find module ‘Control.Monad.Random’`, try run `stack install MonadRandom`. 

If you see the error message saying `Could not find module ‘System.Random.Shuffle’`, try run `stack install random-shuffle`. 

After installing those packages, run `stack ghci Game.hs` again.


## Some input:
Below are some input functions that I implemented.

-- Check the content of all the cards value including its rank and suit

`>>> showCards allCards`

`Ace_Hearts, Ace_Diamonds, Ace_Spades, Ace_Clubs, ... , King_Diamonds, King_Spades, King_Clubs `

-- Get a random shuffled deck 

`>>> deck <- evalRandIO $ shuffleM $ allCards`

`>>> showCards deck`

`Two_Clubs, Four_Clubs, Ten_Spades, Ace_Diamonds, ..., Queen_Diamonds, King_Spades`

-- Check the cards

`>>> checkcard 1` : check player1's card, and return it

`>>> checkcard 2` : check player2's card, and return it

`>>> checkcard 3` : check player3's card, and return it

`>>> checkcard 4` : check player4's card, and return it

`>>> checkcard 5` : check center card, and return it

-- Run an example sequence action

`>>> action1`: start by playing Seven Diamonds, then play Ace Diamonds and King Diamonds, will return the current game state 

`>>> action2` : start by playing Seven Diamonds, then play Ace Hearts, Two clubs, Nine Diamonds, Four Clubs, Queen Spades, Two Clubs, will return the current game state 


