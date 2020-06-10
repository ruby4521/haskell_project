module Game where

import Card
import Play
import Control.Monad.State
-- import System.Random
import System.Random.Shuffle 
import Control.Monad.Random

-- | Initial game state
initState :: GameState 
initState = GameState {
                player1 = dealHand 0 12, 
                player2 = dealHand 13 25, 
                player3 = dealHand 26 38, 
                player4 = dealHand 39 51, 
                center = []}

-- | check the player's card
checkcard :: Int -> IO ()
checkcard n = do
  if n == 5
    then print "Center card is"
    else print "Player's card"
  putStrLn $ showCards $ evalState (checkCards n) initState

-- | Some sequence of action in a round, and return the GameState
r1 :: State GameState GameState
r1 = do
  currentState <- get
  st <- start
  pl <- (play $ PlayingCards Ace Diamonds) >> 
        (play $ PlayingCards King Diamonds) >> 
        (play $ PlayingCards Ten Diamonds)
  currentState' <- get
  put $ currentState' {center = pl}
  return currentState'

action1 :: IO ()
action1 = do
    putStrLn $ showGameState $ evalState r1 initState



-- | Some sequence of action in a round, and return the GameState
r2 :: State GameState GameState
r2 = do
  currentState <- get
  st <- start
  pl1 <- (play (PlayingCards Ace Hearts)) >> 
         (play (PlayingCards Two Clubs)) >> 
         (play (PlayingCards Nine Diamonds))
  put $ currentState {center = pl1}
  currentState' <- get
  pl2 <- (play (PlayingCards Four Clubs)) >> 
         (play (PlayingCards Queen Spades)) >> 
         (play (PlayingCards Two Clubs))
  currentState'' <- get
  put $ currentState'' {center = pl2}
  return currentState''

action2 :: IO ()
action2 = do
    putStrLn $ showGameState $ evalState r2 initState
