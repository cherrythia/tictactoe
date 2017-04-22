//
//  Utility.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

/**
 *  Class for generic functions
 */
open class Utility {
    
    /**
    Unwraps optional values
    - paramter optionalString: Optional String to be unwrap
    - returns: String
     */
    open static func bindingOptional(_ optionalString : String?) -> String {
        if let str = optionalString {
            return str
        } else {
            return ""
        }
    }
    
}
