//
//  Debug.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

open class DebugLog {
    
    private static let ENABLE_DEBUG = false;
    private static let ENABLE_ERROR = true;
    private static let ENABLE_WARNING = true;
    
    private static let DEBUG_TAG = "DEBUG";
    private static let WARNING_TAG = "WARNING";
    private static let ERROR_TAG = "ERROR";
    
    static func debug(className : String, function: String , msg: String? = nil) {
        if (ENABLE_DEBUG) {
            NSLog("%@ > %@ > %@ : %@", DEBUG_TAG, className, function , Utility.bindingOptional(msg))
        }
    }
    
    static func error(className : String, function: String , msg: String? = nil) {
        if (ENABLE_ERROR) {
            NSLog("%@ > %@ > %@ : %@", ERROR_TAG, className, function , Utility.bindingOptional(msg))
        }
    }
    
    static func warning(className : String, function: String , msg: String? = nil) {
        if (ENABLE_WARNING) {
            NSLog("%@ > %@ > %@ : %@", WARNING_TAG, className, function , Utility.bindingOptional(msg))
        }
    }
    
}
