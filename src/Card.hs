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

-- | data type for card value
data PlayingCards = PlayingCards Rank Suit
            deriving (Show, Eq, Ord)

-- type of mutiple cards
-- type Deck = [PlayingCards]

-- | type of each player's state (cards on hand)
type PlayerCardsHold = [PlayingCards]


-- | type of each player give out cards
type PlayerGiveOut = PlayingCards


-- | type of game state
-- type GameState = [(CardsOnHand, CardsGiven)]

showCards :: PlayingCards -> String
showCards (PlayingCards rank suit) = show rank ++ " -- " ++ show suit

-- | A deck consists of 52 cards
allCards :: [PlayingCards]
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

-- -- | get a random card
-- randomCard :: RandomGen m => Rand m c
-- randomCard =
--     let
--       minB = minBound :: (Bounded c, PlayingCards c) => c
--       maxB = maxBound :: (Bounded c, PlayingCards c) => c in
--       do
--         randomd <- getRandomR(fromEnum minB, fromEnum maxB)
--         return $ toEnum randomd

