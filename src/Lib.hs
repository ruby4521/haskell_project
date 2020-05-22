module Lib
    ( 
        -- someFunc
        allCards, 
        allSuits, 
        allRanks, 
        nRanks, 
        nSuits, 
        getRank, 
        getSuit, 
        compareSuit, 
        compareRank, 
        rollDice
    ) where

import System.Random
-- import System.Random.Shuffle
import System.Random.Shuffle (shuffleM)
import Control.Monad.Random
-- {-# LANGUAGE FlexibleContexts #-}

-- | data type for card: suit and rank
data Suit = Hearts 
            | Diamonds
            | Spades
            | Clubs
            deriving (Show, Eq, Ord, Enum, Bounded, Read)

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

-- data type for card value
data Card = Card Rank Suit
            deriving (Show, Eq, Ord)

-- type of mutiple cards
type Deck = [Card]

-- type of cards on hand
type CardsOnHand = [Card]

-- type of cards given
type CardsGiven = [Card]

-- type of game state
type GameState = [(Card, Card)]

allCards :: Deck
allCards = [ Card rank suit | rank <- [Ace ..], suit <- [Hearts ..] ]

allSuits :: [Suit]
allSuits = [minBound .. maxBound]

allRanks :: [Rank]
allRanks = [minBound .. maxBound]

nRanks :: Int
nRanks = length allRanks

nSuits :: Int
nSuits = length allSuits

getRank :: Card -> Rank
getRank (Card rank _ ) = rank

getSuit :: Card -> Suit
getSuit (Card _ suit) = suit


compareSuit :: (Eq a) => a -> a -> Bool
compareSuit a b
               | a == b = True
               | otherwise = False

compareRank :: (Ord a) => a -> a -> Ordering
compareRank a b
               | a > b = GT
               | a == b = EQ
               | otherwise = LT


-- class Random g where
--   randomSuitR :: RandomGen g => (a, a) -> g -> (a, g)      
--   getStdRandomSuit :: (StdGen -> (a, StdGen)) -> IO a 

-- instance Random Suit where
--   randomSuitR (minBoundS, maxBoundS) = 

rollDice :: IO Int
rollDice = getStdRandom $ randomR (1, 4)

minBoundS :: Suit
minBoundS = minBound

maxBoundS :: Suit
maxBoundS = maxBound

-- rollSuit :: IO Suit
-- rollSuit = getStdRandom $ randomSuitR (minBoundS, maxBoundS)

-- randomSuit :: RandomGen m => Rand m Suit
-- randomSuit =
--   let
--     minS = minBound :: Suit
--     maxS = maxBound :: Suit in
--     do
--       randomn <- getRandomR(fromEnum minS, fromEnum maxS);
--       return $ toEnum randomn

-- -- | Random Card
-- randomCard :: RandomGen m => Rand m c

--   fullDeck = [minBound .. maxBound]
-- --   dedupe l = nub l
--   shuffle deck = shuffleM deck
--   randomCard =
--     let
--       minB = minBound :: (Bounded c, Card c) => c
--       maxB = maxBound :: (Bounded c, Card c) => c in
--       do
--         randomd <- getRandomR(fromEnum minB, fromEnum maxB)
--         return $ toEnum randomd
