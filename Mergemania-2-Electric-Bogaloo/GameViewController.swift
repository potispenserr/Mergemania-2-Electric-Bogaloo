//
//  GameViewController.swift
//  Mergemania-2-Electric-Bogaloo
//
//  Created by admin on 2020-10-21.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    enum WhoWon {
        case Nobody, Player1, Player2
    }
    public var gameState = WhoWon.Player1 //dab
    public var maxPoints = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        gameState = WhoWon.Nobody
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MyScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
