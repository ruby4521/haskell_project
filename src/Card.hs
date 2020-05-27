-- {-# LANGUAGE ScopedTypeVariables #-}
module Card
    -- ( 
    --     -- someFunc
    --     allCards, 
    --     allSuits, 
    --     allRanks, 
    --     nRanks, 
    --     nSuits, 
    --     getRank, 
    --     getSuit, 
    --     compareSuit, 
    --     compareRank, 
    --     rollDice, 
    --     shuffle, 
    --     shuffleD
    --     PlayingCards
    --     -- randomCard
    -- )
     where

import System.Random
import System.Random.Shuffle (shuffleM)
import Control.Monad.Random
import Control.Monad.State

-- | data type for card: suit and rank
data Rank = Ace
          | Two
          | Three
          | Four
          | Five
          | Six
          | Seven
          | Eight
          | Nine
          | Ten
          | Jack
          | Queen
          | King
        deriving (Show, Eq, Ord, Enum, Bounded)

data Suit = Hearts 
          | Diamonds
          | Spades
          | Clubs
        deriving (Show, Eq, Ord, Enum, Bounded, Read)

-- data type for card value
data PlayingCards = PlayingCards Rank Suit
            deriving (Show, Eq, Ord)

-- type of mutiple cards
type Deck = [PlayingCards]

-- type of each player's state (cards on hand)
type PlayerCardsHold = [PlayingCards]


-- type of each player give out cards
type PlayerGiveOut = PlayingCards


-- type of game state
-- type GameState = [(CardsOnHand, CardsGiven)]

showCards :: PlayingCards -> String
showCards (PlayingCards rank suit) = show rank ++ " -- " ++ show suit

-- A deck consists of 52 cards
allCards :: Deck
allCards = [ PlayingCards rank suit | rank <- [Ace ..], suit <- [Hearts ..] ]


allRanks :: [Rank]
allRanks = [minBound .. maxBound]

allSuits :: [Suit]
allSuits = [minBound .. maxBound]

nRanks :: Int
nRanks = length allRanks

nSuits :: Int
nSuits = length allSuits


-- | Get the card's rank and suit
getRank :: PlayingCards -> Rank
getRank (PlayingCards rank _ ) = rank

getSuit :: PlayingCards -> Suit
getSuit (PlayingCards _ suit) = suit


-- | Compare the suit and ranl
compareSuit :: Eq a => a -> a -> Bool
compareSuit a b
               | a == b = True
               | otherwise = False

compareRank :: Ord a => a -> a -> Ordering
compareRank a b
               | a > b = GT
               | a == b = EQ
               | otherwise = LT


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
player1Get :: Int -> Int -> [a] -> [a]
player1Get m n list = dispRange m n list

player2Get :: Int -> Int -> [a] -> [a]
player2Get m n list = dispRange m n list

player3Get :: Int -> Int -> [a] -> [a]
player3Get m n list = dispRange m n list

player4Get :: Int -> Int -> [a] -> [a]
player4Get m n list = dispRange m n list


-- | Shuffle a deck of cards
-- >>> deck <- evalRandIO $ shuffle $ allCards 
-- >>> deck
shuffle :: RandomGen m => [c] -> Rand m [c]
shuffle deck = shuffleM deck

-- | shuffle a deck
shuffleD :: IO [PlayingCards]
shuffleD = do 
    deck <- evalRandIO $ shuffle $ allCards 
    return deck

-- | Apply player state with monad state
-- https://stackoverflow.com/questions/24103108/where-is-the-data-constructor-for-state
-- state :: (s -> (a, s)) -> State s a

-- pop :: State Stack Int  
-- pop = state $ \(x:xs) -> (x,xs)  

-- | Give out cards, similar to pop from a stack
giveoutCards :: State PlayerCardsHold PlayerGiveOut
giveoutCards = state $ \(x:xs) -> (x,xs)

-- push :: Int -> State Stack ()  
-- push a = state $ \xs -> ((),a:xs)  

-- | Get cards, similar to push item to a stack
getCards :: PlayingCards -> State PlayerCardsHold ()
getCards y = state $ \xs -> ((), y:xs)

-- | Check cards
checkCards :: State PlayerCardsHold PlayerGiveOut
checkCards = state $ \(x:xs) -> (x,x:xs)

-- | Each player's state
-- >>> runState player1State []
-- >>> (PlayingCards Ace Hearts,[])
player1State :: State PlayerCardsHold PlayingCards
player1State = do
  getCards $ PlayingCards Ace Hearts
  getCards $ PlayingCards Ace Clubs
  -- giveoutCards
  checkCards

player2State :: State PlayerCardsHold PlayingCards
player2State = do
  getCards $ PlayingCards Ace Hearts
  getCards $ PlayingCards Ace Clubs
  getCards $ PlayingCards Ace Diamonds
  giveoutCards

player3State :: State PlayerCardsHold PlayingCards
player3State = do
  getCards $ PlayingCards Ace Hearts
  getCards $ PlayingCards Ace Clubs
  giveoutCards

player4State :: State PlayerCardsHold PlayingCards
player4State = do
  getCards $ PlayingCards Ace Hearts
  getCards $ PlayingCards Ace Clubs
  giveoutCards


-- -- | get a random card
-- randomCard :: RandomGen m => Rand m c
-- randomCard =
--     let
--       minB = minBound :: (Bounded c, PlayingCards c) => c
--       maxB = maxBound :: (Bounded c, PlayingCards c) => c in
--       do
--         randomd <- getRandomR(fromEnum minB, fromEnum maxB)
--         return $ toEnum randomd

