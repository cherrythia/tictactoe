//
//  StateDefinition.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

/**
 * Sate of the game play.
 */
public enum GameState {
    case GameActive ,   //Game started.
    GameInactive        //Game not started.
}

/**
 * State of the Box.
 */
public enum Player : Int {
    case Unknown = -1,      //State of the box is not player a nor b, i.e not selected yet.
    PlayerA = 0,
    PlayerB = 1
}
