//
//  Constants.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 15/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

/**
 Constants that can be reused in different views
 */
struct Constants {
    
    struct LocalizedString {
        
        static let PlayerA_Title = NSLocalizedString("Player A", comment: "Title of player A")
        static let PlayerB_Title = NSLocalizedString("Player B", comment: "Title of player B")
        
        //draw
        static let Draw_Title = NSLocalizedString("Draw Title", comment: "Title for draw")
        
        //win
        static let Win_Title = NSLocalizedString("Win Title", comment: "Title for Win")
        
        //Scores
        static let PlayerA_Score = NSLocalizedString("Player A Score", comment: "Title of player A Score")
        static let PlayerB_Score = NSLocalizedString("Player B Score", comment: "Title of player B Score")
        
        static let OK = NSLocalizedString("Ok", comment: "Title for the Ok buttons")

    }
}
