module Card where

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
        deriving (Show, Eq, Ord, Enum, Bounded)

-- | data type for card value
data PlayingCards = PlayingCards Rank Suit
            deriving (Show, Eq, Ord)

-- | Pretty printer of a list of cards
showCards :: [PlayingCards] -> String
showCards [] = []
showCards ((PlayingCards rank suit):ns) = show rank ++ "_" ++ show suit ++ " " ++ showCards ns

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