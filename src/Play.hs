{-# LANGUAGE BlockArguments #-}
module Play where

import Card
import Control.Monad.State 
import System.Random
import Control.Monad.Random
import System.Random.Shuffle


-- | type of each player's state (cards on hand)
type PlayerCardsHold = [PlayingCards]

-- | type of each player give out cards
type PlayerGiveOut = PlayingCards

type DeckCardsHold = [PlayingCards]

-- | Shuffle a deck of cards with IO monad
-- >>> deck <- evalRandIO $ shuffle $ allCards 
-- >>> deck
-- shuffle :: RandomGen m => [c] -> Rand m [c]
-- shuffle xs = shuffleM xs

-- | shuffle a deck
-- shuffleD :: IO [PlayingCards]
-- shuffleD = do 
--     deck <- evalRandIO $ shuffle $ allCards 
--     -- deck  liftRand $ shuffle $ allCards
--     return $ deck 


-- | Apply player state with monad state
-- https://stackoverflow.com/questions/24103108/where-is-the-data-constructor-for-state
-- state :: (s -> (a, s)) -> State s a
-- runState :: State s a -> s -> (a, s)

-- pop :: State Stack Int  
-- pop = state $ \(x:xs) -> (x,xs)  

-- | Give out cards, similar to pop from a stack
giveoutCards :: State PlayerCardsHold PlayerGiveOut
giveoutCards = state $ \(x:xs) -> (x,xs)

-- | Check cards
checkCards :: State PlayerCardsHold PlayerGiveOut
checkCards = state $ \(x:xs) -> (x,x:xs)

-- push :: Int -> State Stack ()  
-- push a = state $ \xs -> ((),a:xs)  

-- | Get cards, similar to push item to a stack
get1Card :: PlayingCards -> State PlayerCardsHold ()
get1Card y = state $ \xs -> ((), y:xs)

getnCards :: [PlayingCards] -> State PlayerCardsHold ()
getnCards ys = state $ \xs -> ((), ys++xs)






-- | Each player's state
-- >>> runState player1State []
-- (PlayingCards Ace Clubs,[PlayingCards Ace Clubs,PlayingCards Ace Hearts])
-- shuffle': do a random shuffle without IO monad
-- http://hackage.haskell.org/package/random-shuffle-0.0.4/docs/System-Random-Shuffle.html

player1State :: State PlayerCardsHold PlayingCards
player1State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  getnCards $ playerGet 0 12 deck
  checkCards

player2State :: State PlayerCardsHold PlayingCards
player2State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  getnCards $ playerGet 13 25 deck
  checkCards

player3State :: State PlayerCardsHold PlayingCards
player3State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  getnCards $ playerGet 26 38 deck
  giveoutCards

player4State :: State PlayerCardsHold PlayingCards
player4State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  getnCards $ playerGet 39 51 deck
  -- giveoutCards
  checkCards

deckState :: State DeckCardsHold PlayingCards
deckState = undefined

run :: State PlayingCards PlayingCards -> (PlayingCards, PlayerCardsHold)
run = undefined

-- | game state
type Game = [PlayerCardsHold]

gameState :: State Game PlayingCards
gameState = undefined


-- | Roll the dice to determine the sequence of players
rollDice :: IO Int
rollDice = getStdRandom $ randomR (1, 4)

-- | Draw one card from the deck 
-- draw1 :: Int -> [c] -> Maybe ([[c]],[c])

getnthCards :: Int -> [a] -> a
getnthCards n cardsList = cardsList !! n

-- | Display a range from a list: dispRange low high from a list
-- https://stackoverflow.com/questions/52711108/how-display-list-given-range-in-haskell
dispRange :: Int -> Int -> [a] -> [a]
dispRange i j cardsList = take (j-i+1) (drop i cardsList)

-- take :: Int -> [a] -> [a]
-- take n, applied to a list xs, returns the prefix of xs of length n, or xs itself if n > length xs
-- drop :: Int -> [a] -> [a]
-- drop n xs returns the suffix of xs after the first n elements, or [] if n > length xs

-- | Each player get the cards from deck without state monad
playerGet :: Int -> Int -> [a] -> [a]
playerGet m n xs = dispRange m n xs
