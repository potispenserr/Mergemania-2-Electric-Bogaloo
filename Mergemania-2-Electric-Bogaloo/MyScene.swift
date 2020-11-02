//
//  MyScene.swift
//  Mergemania-2-Electric-Bogaloo
//
//  Created by admin on 2020-10-30.
//  Copyright © 2020 admin. All rights reserved.
//

import SpriteKit
import GameplayKit

class MyScene: SKScene {
    private var scoreList : SKLabelNode?
    private var button : SKLabelNode?
    private var dab : SKLabelNode?
    
    private var highScoreText = UITextField()
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func printScores() {
        var listMaster3000 = ""
        for i in 0...9 {
            if isKeyPresentInUserDefaults(key: "NAME\(i)") && isKeyPresentInUserDefaults(key: "HIGHSCORE\(i)") {
                var tmp = UserDefaults.standard.string(forKey: "NAME\(i)")
                tmp?.append(": ")
                tmp?.append(String(UserDefaults.standard.integer(forKey: "HIGHSCORE\(i)")))
                tmp?.append("\n")
                listMaster3000.append(tmp!)
            }
        }
        scoreList?.text = listMaster3000
    }
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        print("life is pain")
        
        self.scoreList = self.childNode(withName: "//scoreList") as? SKLabelNode
        
        printScores()
        
        button?.position = CGPoint(x: 0,y: 0)
        
        // Get label node from scene and store it for use later
        //self.p1label = self.childNode(withName: "//p1s") as? SKLabelNode
        
        button = SKLabelNode(text: "Play")
        button!.position = CGPoint(x: 0, y: 200)
        button!.color = UIColor.white
        button!.name = "playButton"
        addChild(button!)
        
        if let gvc = self.view?.window?.rootViewController as? GameViewController {
            if gvc.gameState != GameViewController.WhoWon.Nobody {
                highScoreText = UITextField(frame: CGRect(x: self.frame.width/2-160, y: 100 ,width: 320, height: 40))
                if gvc.gameState == GameViewController.WhoWon.Player1 {
                    highScoreText.attributedPlaceholder = NSAttributedString(string:"Player 1 name:", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
                }
                else {
                    highScoreText.attributedPlaceholder = NSAttributedString(string:"Player 2 name:", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
                }
                highScoreText.textColor = UIColor.white
                //highScoreText.backgroundColor = UIColor.gray
                self.view!.addSubview(highScoreText)
                //txtTitle
                
                dab = SKLabelNode(text: "Submit (to the temptation)")
                
                //let bs = /self.size.width*self.frame.width
                dab!.position = CGPoint(
                    x:0,
                    y:self.size.height/2-180)
                
                
                
                dab!.color = UIColor.white
                dab!.name = "submitButton"
                addChild(dab!)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if button?.contains(t.location(in: self)) ?? false {

                // Load game scene?
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        highScoreText.removeFromSuperview()
                        
                        // Present the scene
                        view.presentScene(scene)
                    }
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
            if let gvc = self.view?.window?.rootViewController as? GameViewController {
                if dab?.contains(t.location(in: self)) ?? false {
                    var insertIndex = 10
                    // get highscores
                    for i in (0...9).reversed() {
                        if !isKeyPresentInUserDefaults(key: "HIGHSCORE\(i)") ||
                           gvc.maxPoints > UserDefaults.standard.integer(forKey: "HIGHSCORE\(i)") {
                            insertIndex = i
                        }
                    }
                    if insertIndex < 10 {
                        // shift highscores
                        for i in ((insertIndex+1)...9).reversed() {
                            if isKeyPresentInUserDefaults(key: "HIGHSCORE\(i-1)") {
                                // score
                                let score = UserDefaults.standard.integer(forKey: "HIGHSCORE\(i-1)")
                                UserDefaults.standard.set(score, forKey: "HIGHSCORE\(i)")
                                // name
                                let name = UserDefaults.standard.string(forKey: "NAME\(i-1)")
                                UserDefaults.standard.set(name, forKey: "NAME\(i)")
                            }
                        }
                        // add new score
                        UserDefaults.standard.set(gvc.maxPoints, forKey: "HIGHSCORE\(insertIndex)")
                        UserDefaults.standard.set(highScoreText.text, forKey: "NAME\(insertIndex)")
                    }
                    
                    printScores()
                    
                    highScoreText.removeFromSuperview()
                    removeChildren(in: [dab!])
                }
            }
        }
    }
}
