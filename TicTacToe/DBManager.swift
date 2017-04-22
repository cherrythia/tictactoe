//
//  DBManager.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

open class DBManager {
    
    private var boxesStates : [Player] = []
    
    private let KEY_BOXESSTATE = "BOXESSTATE"
    
    static let sharedInstance = DBManager()     //Singleton
    
    private init() {
        
        boxesStates = [Player](repeatElement(Player.Unknown, count: 9))
        
        readFromCache() //read from cache when app launch
    }
    
    /**
     Getter for state of the boxes
    */
    open func getBoxesState() -> [Player]? {
        if boxesStates.count == 9 {
            return boxesStates
        } else {
            return nil
        }
    }
    
    /**
     Setter for state of the boxes
     */
    open func setBoxesState(_ _boxesStates : [Player]) {
        boxesStates = _boxesStates
        //_ = saveIntoCache()
    }
    
    /**
     *  Read from cache the state of the boxes
     */
    private func readFromCache() {
        if let _boxesStates = UserDefaults.standard.value(forKey: KEY_BOXESSTATE) as? [Player] {
            if _boxesStates.count == 9 {
                boxesStates = _boxesStates
            }
        }
    }
    
    /**
     Save state of the boxes into cache
     - returns: TRUE if cached, other FALSE.
     */
    private func saveIntoCache() -> Bool {
        if boxesStates.count == 9 {
            UserDefaults.standard.setValue(boxesStates, forKey: KEY_BOXESSTATE)
            return UserDefaults.standard.synchronize()
        } else {
            return false
        }
    }
    
}
