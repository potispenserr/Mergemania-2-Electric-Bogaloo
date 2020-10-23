//
//  GameScene.swift
//  Mergemania-2-Electric-Bogaloo
//
//  Created by admin on 2020-10-21.
//  Copyright © 2020 admin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var pointList = [Int: [CGPoint]]()
    let touches = [UIBezierPath]()
    var isTouching = false
    
    override func didMove(to view: SKView) {
        print("life is pains")
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 3
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(180), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        let spinnyShit = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        spinnyShit.position = CGPoint(x: 100, y: 200)
        spinnyShit.strokeColor = SKColor.yellow
        spinnyShit.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(1), duration: 1)))
        self.addChild(spinnyShit)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    func intersect(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat, x4: CGFloat, y4: CGFloat) -> Bool {

      // Check if none of the lines are of length 0
        if ((x1 == x2 && y1 == y2) || (x3 == x4 && y3 == y4)) {
            return false
        }

        let denominator = ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1))

      // Lines are parallel
        if (denominator == 0) {
            return false
        }

        let ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denominator
        let ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / denominator

      // is there intersection along the segments
        if (ua < 0 || ua > 1 || ub < 0 || ub > 1) {
            return false
        }

      // Don't return a object with the x and y coordinates of the intersection, return true

        return true
    }
    
    func checkList(points: inout [CGPoint]) -> Bool {
        //points.append(point)
        
        if points.count < 5 {
            return true
        }
        let p1 = points[points.count-2]
        let p2 = points[points.count-1]
        for index in 1...(points.count - 4){
            let p3 = points[index]
            let p4 = points[index+1]
            
            if intersect(x1: p1.x, y1: p1.y, x2: p2.x, y2: p2.y, x3: p3.x, y3: p3.y, x4: p4.x, y4: p4.y) {
                print("Lines are intersecting")
                return false
            }
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            
            pointList[t.hash] = [CGPoint]()
            pointList[t.hash]?.append(t.location(in: self))
            //pointList[t.hash].append(t.location(in: self))
            //print(pointList[t.hash] ?? "save me from the nothing i've become")
            
           
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            pointList[t.hash]?.append(t.location(in: self))
            if !checkList(points: &(pointList[t.hash])!){
                print("yeetus deletus")
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
        
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            pointList[t.hash]?.append(t.location(in: self))
            var good = true
            good = checkList(points: &((pointList[t.hash]))!)
            print("kyaie")
            if good {
                let p1 = pointList[t.hash]?.first ?? CGPoint(x: 0, y: 0)
                pointList[t.hash]?.append(p1)
                if checkList(points: &(pointList[t.hash])!) {
                    let lastIndex = pointList[t.hash]!.count-1
                    pointList[t.hash]?.remove(at: lastIndex)
                    
                    let path = UIBezierPath()
                    print("nothing is good")
                    path.move(to: (pointList[t.hash]?.first ?? CGPoint(x: 0, y: 0)))
                    for points in pointList[t.hash]!{
                        path.addLine(to: points)
                        
                    }
                    path.close()
                    //print(path)
                    let shape = SKShapeNode(path: path.cgPath)
                    
                    
                    shape.run(SKAction.sequence([SKAction.wait(forDuration: 3.5),
                    SKAction.fadeOut(withDuration: 0.5),
                    SKAction.removeFromParent()]))
                    
                    
                    
                    self.addChild(shape)
                    
                    //print("Pointslist")
                    //print(pointList[t.hash]!)
                    pointList[t.hash] = nil
                    
                }
            }
            
            if !good {
                print("hippity hoppety")
            }
            
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            //pointList.append(t.location(in: self))
            
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
