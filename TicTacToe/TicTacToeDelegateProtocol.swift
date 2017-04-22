//
//  TicTacToeDelegate.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

protocol TicTacToeDelegateProtocol {
    
    /* State of the 9 boxes */
    func updateBoxesState(boxesState : [Player])
    
    /* Current Player turn */
    func updateActivePlayer(_ player : Player)
    
    /* Winner */
    func updateWinnerPlayer(player : Player)
    
    /* Current Game State */
    func updateGameState(_ gameState : GameState)
}
