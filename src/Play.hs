module Play where

import Card
import Control.Monad.State 
import System.Random
import System.Random.Shuffle
import Control.Monad.Random


-- | type of each player's state (cards on hand)
type PlayerCardsHold = [PlayingCards]
type CenterCards = [PlayingCards]

-- | Global state: Game state
data GameState = GameState {
  player1 :: PlayerCardsHold, 
  player2 :: PlayerCardsHold, 
  player3 :: PlayerCardsHold, 
  player4 :: PlayerCardsHold,
  center :: CenterCards
} deriving (Show)

-- | Apply player state with monad state
-- | Each player get the cards from deck without state monad
-- take n, applied to a list xs, returns the prefix of xs of length n, or xs itself if n > length xs
-- take :: Int -> [a] -> [a]
-- drop n xs returns the suffix of xs after the first n elements, or [] if n > length xs
-- drop :: Int -> [a] -> [a]

playerGet :: Int -> Int -> [a] -> [a]
playerGet m n xs = take (n-m+1) (drop m xs)

-- | Deal the card without state
dealHand :: Int -> Int -> [PlayingCards]
dealHand m n = do 
  let deck = shuffle' allCards 52 (mkStdGen 1)
  x <- playerGet m n deck
  return x




-- | To check if Seven Diamonds is in one of the player's hand, then that player will first play that card
start :: State GameState [PlayingCards]
start = do
  currentState <- get
  let (p1, p2, p3, p4, c) = (player1 currentState, 
                          player2 currentState, 
                          player3 currentState, 
                          player4 currentState, 
                          center currentState)
  case isIn (PlayingCards Seven Diamonds) p1 of
    True -> put (currentState {player1 = delete (PlayingCards Seven Diamonds) p1, center = [PlayingCards Seven Diamonds]})
    False -> put (currentState {player1 = p1, center = c})
  
  currentState' <- get
  let c' = center currentState'
  case isIn (PlayingCards Seven Diamonds) p2 of
    True -> put (currentState' {player2 = delete (PlayingCards Seven Diamonds) p2, center = [PlayingCards Seven Diamonds]})
    False -> put (currentState' {player2 = p2, center = c'})
  
  currentState'' <- get
  let c'' = center currentState''
  case isIn (PlayingCards Seven Diamonds) p3 of
    True -> put (currentState'' {player3 = delete (PlayingCards Seven Diamonds) p3, center = [PlayingCards Seven Diamonds]})
    False -> put (currentState'' {player3 = p3, center = c''})

  currentState''' <- get
  let c''' = center currentState'''
  case isIn (PlayingCards Seven Diamonds) p4 of
    True -> put (currentState''' {player4 = delete (PlayingCards Seven Diamonds) p4, center = [PlayingCards Seven Diamonds]})
    False -> put (currentState''' {player4 = p4, center = c'''})

  currentState'''' <- get
  let c'''' = center currentState''''
  return c''''


-- | Check if a card is in a list of cards
isIn :: Eq a => a -> [a] -> Bool
isIn a xs = case (a `elem` xs) of
                True -> True
                False -> False

-- | Delete that card from the list of cards
delete :: Eq a => a -> [a] -> [a]
delete y xs = filter (not . (==y) ) xs

-- | Play cards
play :: PlayingCards -> State GameState [PlayingCards]
play x = do 
  currentState <- get
  let (p1, p2, p3, p4, c) = (player1 currentState, 
                          player2 currentState, 
                          player3 currentState, 
                          player4 currentState, 
                          center currentState)
  case isIn x p1 of 
    True ->  put (currentState {player1 = delete x p1, center = x:c})
    False -> put (currentState {player1 = p1, center = c})

  currentState' <- get
  let c' = center currentState'
  case isIn x p2 of 
    True ->  put (currentState' {player2 = delete x p2, center = x:c'})
    False -> put (currentState' {player2 = p2, center = c'})

  currentState'' <- get
  let c'' = center currentState''
  case isIn x p3 of 
    True ->  put (currentState'' {player3 = delete x p3, center = x:c''})
    False -> put (currentState'' {player3 = p3, center = c''})

  currentState''' <- get
  let c''' = center currentState'''
  case isIn x p4 of 
    True ->  put (currentState''' {player4 = delete x p4, center = x:c'''})
    False -> put (currentState''' {player4 = p4, center = c'''})

  currentState'''' <- get
  let c'''' = center currentState''''
  return c''''

-- | Check cards
checkCards :: Int -> State GameState [PlayingCards]
checkCards n = do
  currentState <- get
  let (p1, p2, p3, p4, c) = (player1 currentState, 
                          player2 currentState, 
                          player3 currentState, 
                          player4 currentState, 
                          center currentState)
  put (currentState {player1 = p1, 
                     player2 = p2, 
                     player3 = p3, 
                     player4 = p4, 
                     center = c})
  case n of
    1 -> return p1
    2 -> return p2
    3 -> return p3
    4 -> return p4
    5 -> return c

-- | Pretty printer of the GameState
showGameState :: GameState -> String  
showGameState (GameState {player1 = p1, 
                      player2 = p2, 
                      player3 = p3, 
                      player4 = p4, 
                      center = c
                      }) = "Player 1 has: " ++ showCards p1 ++ "\n" ++
                          "Player 2 has: " ++ showCards p2 ++ "\n" ++
                          "Player 3 has: " ++ showCards p3 ++ "\n" ++
                          "Player 4 has: " ++ showCards p4 ++ "\n" ++
                          "Center is: " ++ showCards c