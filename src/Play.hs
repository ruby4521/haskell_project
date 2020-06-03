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
-- type PlayerGiveOut = PlayingCards

-- type PlayerCheck = PlayingCards

type GameCards = [PlayingCards]

-- | Shuffle a deck of cards with IO monad
-- >>> deck <- evalRandIO $ shuffleM $ allCards 
-- >>> deck

-- shufflemy :: RandomGen m => [c] -> Rand m [c]
-- shufflemy xs = shuffleM xs

-- | shuffle a deck
-- shuffleD :: IO [PlayingCards]
-- shuffleD = do 
--     deck <- evalRandIO $ shuffle $ allCards 
--     -- deck  liftRand $ shuffle $ allCards
--     return $ deck 

-- | Roll the dice to determine the sequence of players
rollDice :: IO Int
rollDice = getStdRandom $ randomR (1, 4)

-- | Draw one card from the deck 
-- draw1 :: Int -> [c] -> Maybe ([[c]],[c])

getnthCards :: Int -> [a] -> a
getnthCards n cardsList = cardsList !! n

-- | Display a range from a list: dispRange low high from a list

-- take :: Int -> [a] -> [a]
-- take n, applied to a list xs, returns the prefix of xs of length n, or xs itself if n > length xs
-- drop :: Int -> [a] -> [a]
-- drop n xs returns the suffix of xs after the first n elements, or [] if n > length xs

-- | Each player get the cards from deck without state monad
playerGet :: Int -> Int -> [a] -> [a]
playerGet m n xs = take (n-m+1) (drop m xs)

-- | Apply player state with monad state
-- https://stackoverflow.com/questions/24103108/where-is-the-data-constructor-for-state
-- state :: (s -> (a, s)) -> State s a
-- runState :: State s a -> s -> (a, s)

-- pop :: State Stack Int  
-- pop = state $ \(x:xs) -> (x,xs)  

-- | Give out cards, similar to pop from a stack
giveoutCards :: State PlayerCardsHold PlayingCards
giveoutCards = state $ \(x:xs) -> (x,xs)

-- | Check cards
checkCards :: State PlayerCardsHold PlayingCards
checkCards = state $ \(x:xs) -> (x,x:xs)

-- checkStart :: State PlayerCardsHold PlayingCards
-- checkStart = state $ \(x:xs) -> if (PlayingCards Seven Diamonds) `elem` (x:xs) == True
--                                   then (PlayingCards Seven Diamonds, xs)
-- checkStart = undefined

-- | Check game 
checkGame :: State GameCards PlayingCards
checkGame = state $ \(ys:xs) -> (ys,ys:xs)
-- checkGame = undefined

-- push :: Int -> State Stack ()  
-- push a = state $ \xs -> ((),a:xs)  

-- | Get cards, similar to push item to a stack, primitive: put x
-- get1Card :: PlayingCards -> State PlayerCardsHold ()
-- get1Card y = state $ \xs -> ((), y:xs)

getnCards :: [PlayingCards] -> State PlayerCardsHold ()
getnCards ys = state $ \xs -> ((), ys++xs)


-- | Each player's state
-- >>> runState player1State []
-- >>> evalState player1State []
--  returns the final result: PlayingCards Ten Clubs
-- >>> execState player1State []
--  returns the final state: [PlayingCards Ten Clubs,PlayingCards Ten Spades, ....,]
-- shuffle': do a random shuffle without IO monad
-- http://hackage.haskell.org/package/random-shuffle-0.0.4/docs/System-Random-Shuffle.html


player1State :: State PlayerCardsHold PlayingCards
player1State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  put $ playerGet 0 12 deck
  -- getnCards $ playerGet 0 12 deck
  checkCards

player2State :: State PlayerCardsHold PlayingCards
player2State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  -- getnCards $ playerGet 13 25 deck
  put $ playerGet 13 25 deck
  checkCards

player3State :: State PlayerCardsHold PlayingCards
player3State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  -- getnCards $ playerGet 26 38 deck
  put $ playerGet 26 38 deck
  giveoutCards

player4State :: State PlayerCardsHold PlayingCards
player4State = do
  let deck = shuffle' allCards 52 (mkStdGen 0)
  -- getnCards $ playerGet 39 51 deck
  put $ playerGet 39 51 deck
  -- giveoutCards
  checkCards


-- deckState :: State DeckCardsHold PlayingCards
-- deckState = undefined

-- | game state
-- data GameState = GameState {
--   player1State :: PlayingCards
--   player2State :: PlayingCards
--   player3State :: PlayingCards
--   player4State :: PlayingCards
-- }

-- gameState :: State Game PlayingCards
-- gameState = undefined

run1 :: IO ()
run1 = do
  putStrLn "Player1 check:"
  print $ evalState player1State []
  putStrLn "Player1 hand:"
  print $ execState player1State []

run2 :: IO ()
run2 = do
  putStrLn "Player2 check:"
  print $ evalState player2State []
  putStrLn "Player2 hand:"
  print $ execState player2State []

run3 :: IO ()
run3 = do
  putStrLn "Player3 check:"
  print $ evalState player3State []
  putStrLn "Player3 hand:"
  print $ execState player3State []

run4 :: IO ()
run4 = do
  putStrLn "Player4 check:"
  print $ evalState player4State []
  putStrLn "Player4 hand:"
  print $ execState player4State []

-- safeDiv :: Int -> Int -> Maybe Int
-- safeDiv x y = do
--   guard (y /= 0)
--   return (x `div` y)

