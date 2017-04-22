//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chia Wei Zheng Terry on 14/4/17.
//  Copyright © 2017 Chia Wei Zheng Terry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var boardImage: UIImageView!
    @IBOutlet var touchArea: UIView!
    
    var _boxesState : [Player] = []
    var _currentPlayer : Player = Player.PlayerA //default player A
    var _ticTacToemanager : TicTacToeManager?
    var isGameADraw = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupManager()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI() {
        
        DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "Refresh UI"))
        
        //add user interaction to all the image boxes
        DispatchQueue.main.async {
            if let verticalStack = self.touchArea.subviews.first as? UIStackView {
                for horizontalStacks in verticalStack.subviews {
                    if let horizontalStack = horizontalStacks as? UIStackView {
                        for imageViews in horizontalStack.subviews {
                            if let box = imageViews as? UIImageView {
                                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.boxTapped(tapGestureRegconizer:)))
                                box.isUserInteractionEnabled = true
                                box.addGestureRecognizer(tapGestureRecognizer)
                                
                                if self._boxesState[box.tag] == Player.PlayerA {
                                    box.image = UIImage(named: Image.getName(Image.SymbolCross))
                                    box.isUserInteractionEnabled = false
                                } else if self._boxesState[box.tag] == Player.PlayerB {
                                    box.image = UIImage(named: Image.getName(Image.SymbolCircle))
                                    box.isUserInteractionEnabled = false
                                } else { //unknown
                                    box.image = nil
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func setupManager() {
        _ticTacToemanager = TicTacToeManager()
        _ticTacToemanager?.delegate = self
        
        if let states = _ticTacToemanager?.getBoxesState() {
            _boxesState = states
        }
    }
    
    func boxTapped(tapGestureRegconizer : UITapGestureRecognizer) {
        if let imageView = tapGestureRegconizer.view  {
            let tag = imageView.tag
            DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: NSString(format: "Box selected at id: %d", tag) as String)
            
            _boxesState[tag] = _currentPlayer
            _ticTacToemanager?.updatePlayerMove(player: _currentPlayer, boxesState: _boxesState)
        }
    }
    
    
}

extension ViewController : TicTacToeDelegateProtocol {
    
    /* State of the 9 boxes */
    func updateBoxesState(boxesState : [Player]) {
        
        DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "boxesStae \(_boxesState)"))
        
        _boxesState = boxesState
        
        setupUI()   //refresh UI
    }
    
    /* Current Player turn */
    func updateActivePlayer(_ player : Player) {
        self._currentPlayer = player
    }
    
    /* Winner */
    func updateWinnerPlayer(player : Player) {
        
        if player == Player.Unknown {
            isGameADraw = true
        } else {
            self._currentPlayer = player
        }
    }
    
    /* Current Game State */
    func updateGameState(_ gameState : GameState) {
        
        if (gameState == GameState.GameInactive) {
            
            DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "activePlayer:\(_currentPlayer) isADraw:\(isGameADraw)"))
            
            //disable touch for all the boxes
            touchArea.isUserInteractionEnabled = false
            
            //retrieve high score and display
            var player = ""
            var playerAScore = 0
            var playerBScore = 0
            if _currentPlayer == Player.PlayerA {
                player = Constants.LocalizedString.PlayerA_Title
            } else if _currentPlayer == Player.PlayerB {
                player = Constants.LocalizedString.PlayerB_Title
            }
            
            if let gameScore = _ticTacToemanager?.getGameScore() {
                playerAScore = gameScore[Player.PlayerA]!
                playerBScore = gameScore[Player.PlayerB]!
                
                DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "playAScore:\(playerAScore) playerB:\(playerBScore)"))
            }
            
            if (_currentPlayer != Player.Unknown && !isGameADraw) {
                
                //alert to notify the players game is over and scores
                let alert = UIAlertController(title: player + Constants.LocalizedString.Win_Title, message: Constants.LocalizedString.PlayerA_Score + " \(playerAScore) \n" + Constants.LocalizedString.PlayerB_Score + " \(playerBScore)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: Constants.LocalizedString.OK, style: .default) { action in
                    DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "calling to reset game"))
                    self._ticTacToemanager?.resetGame() //reset the game
                    self.touchArea.isUserInteractionEnabled = true //enable the touch
                    alert.dismiss(animated: true, completion: nil)
                })
                self.present(alert, animated: true, completion: nil)
            }
            
            if (isGameADraw) { //game tie
                
                isGameADraw = false
                
                //alert to notify the players game is over and scores
                let alert = UIAlertController(title:Constants.LocalizedString.Draw_Title, message: Constants.LocalizedString.PlayerA_Score + " \(playerAScore) \n" + Constants.LocalizedString.PlayerB_Score + " \(playerBScore)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: Constants.LocalizedString.OK, style: .default) { action in
                    DebugLog.debug(className: NSStringFromClass(type(of:self)), function: #function, msg: String(format: "calling to reset game"))
                    self._ticTacToemanager?.resetGame() //reset the game
                    self.touchArea.isUserInteractionEnabled = true //enable the touch
                    alert.dismiss(animated: true, completion: nil)
                })
                self.present(alert, animated: true, completion: nil)
            }
           
        }
    }
    
}

