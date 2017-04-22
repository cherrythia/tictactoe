//
//  TicTacToeManager.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import UIKit

class TicTacToeManager: NSObject {
    
    public var delegate : TicTacToeDelegateProtocol?
    
    //play state
    private var activePlayer : Player = Player.Unknown
    
    //boxes state
    private var boxesState : [Player] = []
    
    //game state
    private var gameState : GameState = GameState.GameInactive
    
    //game score
    private var gameScore : [Player : Int] = [Player.PlayerA : 0 ,
                                              Player.PlayerB : 0]
    
    //combination for the winning positions of the boxes
    private let winningPositions : [[Int]] = [
        [0,1,2],[3,4,5],[6,7,8],     //horizontal winning posistions
        [0,3,6],[1,4,7],[2,5,8],     //vertical winning positions
        [0,4,8],[2,4,6]]             //diagonal winning positions
    
    
    override init() {
        
        if let _boxesState = DBManager.sharedInstance.getBoxesState() {
            boxesState = _boxesState
        }
    }
    
    /**
     Getter for the states for the 9 boxes.
     */
    public func getBoxesState() -> [Player] {
        return boxesState
    }
    
    /**
     Getter for the state of the game.
     */
    public func getGameState() -> GameState {
        return gameState
    }
    
    /**
     Getter for the score of the players
     */
    public func getGameScore() -> [Player : Int] {
        return gameScore
    }
    
    /**
     Update when a player moved
     - parameter : Player moved
     - parameter : State of the boxes
     */
    public func updatePlayerMove(player : Player, boxesState: [Player]) {
        
        //set the active player
        self.activePlayer = player
        
        //next player turn
        var nextPlayer = Player.Unknown
        self.activePlayer == Player.PlayerA ? (nextPlayer = Player.PlayerB) : (nextPlayer = Player.PlayerA)
        delegate?.updateActivePlayer(nextPlayer)
        
        //update the 9 boxes state
        self.boxesState = boxesState
        DBManager.sharedInstance.setBoxesState(self.boxesState)
        
        //check if any player has won the game
        checkIfActivePlayerHasWon()
        
        delegate?.updateBoxesState(boxesState: boxesState)
    }
    
    /* logic to check if game has won the game, or is a draw */
    private func checkIfActivePlayerHasWon() {
        
        for winnngPosition in winningPositions { //each set of winning position
            if (boxesState[winnngPosition[0]] == boxesState[winnngPosition[1]] && //3 boxes must be the same player
                boxesState[winnngPosition[1]] == boxesState[winnngPosition[2]] &&
                boxesState[winnngPosition[0]] != Player.Unknown)                  //and cannot be unknown
            {
                DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "Game has ended"))
                
                //game has won
                delegate?.updateWinnerPlayer(player: activePlayer)
            
                DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "%d won the game", activePlayer.rawValue))
            
                //update game score
                _ = updateGameScore(winner: activePlayer)
            
                gameState = GameState.GameInactive
                delegate?.updateGameState(gameState)
                
                return
            }
        }
        
        //check if game is a draw
        DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "Check if Game is Tie"))
        DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "\(boxesState)"))
        
        var hasAnyUnknownState = false
        
        for state in boxesState {
            if state == Player.Unknown {
                hasAnyUnknownState = true
            }
        }
        
        if hasAnyUnknownState == false { //all the 9 boxes has no unknown anymore, game is a draw
            
             DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "Game Tie"))
            delegate?.updateWinnerPlayer(player: Player.Unknown)
            
            gameState = GameState.GameInactive
            delegate?.updateGameState(gameState)
        }
        
    }
    
    /**
     Reset Game
     */
    public func resetGame() {
        
        //set all boxes to unknown state
        boxesState = [Player](repeatElement(Player.Unknown, count: 9))
        DBManager.sharedInstance.setBoxesState(self.boxesState)
        
        //update to UI
        delegate?.updateBoxesState(boxesState: boxesState)
        
        DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "Game has reset"))
    }
    
    
    private func updateGameScore(winner : Player) -> Bool {
        if let _ = gameScore[winner] {
            gameScore[winner] = gameScore[winner]! + 1
            return true
        }
        return false
    }
    
}
