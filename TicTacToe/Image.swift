//
//  Image.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 15/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import Foundation

/*
 Image class provides reference to image resources stored in the image.plist file
 */
open class Image {
    
    private static let FILENAME = "Image"
    private static let FILETYPE = "plist"
    
    open static let SymbolCircle = "SymbolCircle"
    open static let SymbolCross = "SymbolCross"
    
    
    open static func getName(_ tag : String) -> String {
        var resource : String = ""
        
        let _targetURL : String? = Bundle.main.path(forResource: FILENAME, ofType: FILETYPE)
        
        if let targetURL = _targetURL {
            
            let _dict = NSDictionary(contentsOfFile: targetURL)
            
            if let dict = _dict {
                let anyValue = dict.object(forKey: tag)
                
                if let _ = anyValue {
                    resource = anyValue as! String
                }
            }
        }
        
        return resource
    }
    
    
}
