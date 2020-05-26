module Main where

import Card
import System.Random
import System.Random.Shuffle (shuffleM)
import Control.Monad.Random
-- import Control.Monad.State


-- | Main
intro :: IO ()
intro = do
    putStrLn "Hi, this is a fan tan game"
    putStrLn "Player1 roll the dice"
    dice1 <- rollDice
    print dice1
    putStrLn "Player2 roll the dice"
    dice2 <- rollDice
    print dice2
    putStrLn "Player3 roll the dice"
    dice3 <- rollDice
    print dice3
    putStrLn "Player4 roll the dice"
    dice4 <- rollDice
    print dice4
    if dice1 == dice2
        then 
            do
                putStrLn "Player1 roll the dice again"
                dice1' <- rollDice
                print dice1'
                putStrLn "Player2 roll the dice again"
                dice2' <- rollDice
                print dice2'
        else
            return ()

-- shuffleDeck :: IO ()
-- shuffleDeck = do 
--     putStrLn "Please shuffle the deck"
--     deck <- evalRandIO $ shuffle $ allCards
--     print deck 

main :: IO ()
main = intro
    -- op1 <- intro
    -- op2 <- shuffleDeck
    -- print op1
    -- print op2