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
    
    private var p1label : SKLabelNode?
    private var p2label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var pointList = [Int: [CGPoint]]()
    let touches = [UIBezierPath]()
    
    var p1touchHashes = [Int]() // List of touch hashes
    var p2touchHashes = [Int]() // List of touch hashes
    var p1score = 0
    var p2score = 0
    
    
    var isTouching = false
    var spinnyRect : SKShapeNode?
    var spinnyCircle : SKShapeNode?
    var spinnyTriangle : SKShapeNode?
    
    var greenRects = [SKShapeNode]()
    var redRects = [SKShapeNode]()
    var blueRects = [SKShapeNode]()
    var yellowRects = [SKShapeNode]()
    var pinkRects = [SKShapeNode]()
    
    let screenSize = UIScreen.main.bounds
    
    let screenMargins = 20
    
    var randomPos = CGPoint(x: 100, y: 100)
    
    var circles = [SKShapeNode]()
    
    var failure = false
    
    
    override func didMove(to view: SKView) {
        let screenWidth = Int(screenSize.width/2)
        let screenHeight = Int(screenSize.height/2)
        let screenMargins = 20
        
        print("life is pain")
        print("Screen width \(screenSize.width)")
        print("Screen height \(screenSize.height)")
        
        
        // Get label node from scene and store it for use later
        self.p1label = self.childNode(withName: "//p1s") as? SKLabelNode
        if let label = self.p1label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.p2label = self.childNode(withName: "//p2s") as? SKLabelNode
        if let label = self.p2label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.01
        let miniw = (self.size.width + self.size.height) * 0.001
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: miniw, height: miniw), cornerRadius: miniw * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 3
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(180), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        self.spinnyRect = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.0)
        if let spinnyRect = self.spinnyRect {
            spinnyRect.fillColor = SKColor.yellow
            //spinnyRect.position = spinnyShitPoint
            spinnyRect.strokeColor = SKColor.black
            spinnyRect.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(1), duration: 1)))
            
            //shape.run(SKAction.sequence([SKAction.wait(forDuration: 0.4),
            //SKAction.fadeOut(withDuration: 0.2),
            //SKAction.removeFromParent()]))
            
        }
        
        //self.spinnyTriangle = SKShapeNode.init(path: <#T##CGPath#>)
        
        self.spinnyCircle = SKShapeNode.init(circleOfRadius: 50)
        
        if let spinnyCircle = self.spinnyCircle {
            spinnyCircle.strokeColor = SKColor.black
            spinnyCircle.fillColor = SKColor.green
            
        }
        
        
        //green rects
        for index in 1...5{
            if let rect = self.spinnyRect?.copy() as! SKShapeNode?{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                print("xpos: \(xpos)")
                print("ypos: \(ypos)")
                
                rect.position = CGPoint(x:
                    Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                    y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))
                print("created green rect \(index) heading to x: \(xpos) y: \(ypos)")
                    
                rect.fillColor = SKColor.green
                var moveRect = SKAction.move(to: CGPoint(x:
                xpos,
                y: ypos), duration: 20)
                
                
                rect.run(moveRect)
                
                greenRects.append(rect)
                self.addChild(rect)
                
            }
            
        }
        
        //red rects
        for _ in 1...5{
            if let rect = self.spinnyRect?.copy() as! SKShapeNode?{
                rect.position = CGPoint(x:
                Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))
                
                rect.fillColor = SKColor.red
                
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                
                rect.position = CGPoint(x:
                    Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                    y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))


                let moveRect = SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20)
                
                rect.run(moveRect)
                
                redRects.append(rect)
                self.addChild(rect)
                
            }
            
        }
        
        //blue rects
        for _ in 1...5{
            if let rect = self.spinnyRect?.copy() as! SKShapeNode?{
                
                rect.position = CGPoint(x:
                Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))
                
                rect.fillColor = SKColor.blue
                
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                
                rect.position = CGPoint(x:
                    Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                    y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))


                let moveRect = SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20)
                
                rect.run(moveRect)
                
                blueRects.append(rect)
                self.addChild(rect)
                
            }
            
        }
        
        //yellow rects
        for _ in 1...5{
            if let rect = self.spinnyRect?.copy() as! SKShapeNode?{
                
                rect.position = CGPoint(x:
                Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))
                
                rect.fillColor = SKColor.yellow
                
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                
                rect.position = CGPoint(x:
                    Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                    y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))


                let moveRect = SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20)
                
                rect.run(moveRect)
                
                yellowRects.append(rect)
                self.addChild(rect)
                
            }
            
        }
        
        //purple rects
        for _ in 1...5{
            if let rect = self.spinnyRect?.copy() as! SKShapeNode?{
                
                rect.position = CGPoint(x:
                Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))
                
                rect.fillColor = SKColor.magenta
                
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                
                rect.position = CGPoint(x:
                    Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins),
                    y: Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins))


                let moveRect = SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20)
                
                rect.run(moveRect)
                
                pinkRects.append(rect)
                self.addChild(rect)
                
            }
            
        }
        let line = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: -screenWidth, y: 0))
        pathToDraw.addLine(to: CGPoint(x: screenWidth, y: 0))
        line.path = pathToDraw
        line.strokeColor = SKColor.white
        self.addChild(line)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { timer in
            print("You're fired!")
            
            
            for rect in self.greenRects{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                rect.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20))
            }
            
            for rect in self.blueRects{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                rect.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20))
            }
            
            for rect in self.redRects{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                rect.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20))
            }
            
            for rect in self.yellowRects{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                rect.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20))
            }
            
            for rect in self.pinkRects{
                let xpos = Int.random(in: -screenWidth + screenMargins...screenWidth - screenMargins)
                let ypos = Int.random(in: -screenHeight + screenMargins...screenHeight - screenMargins)
                rect.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 20))
            }
        }
        
        
        
        /*if let rect1 = self.spinnyRect?.copy() as! SKShapeNode?{
            rect1.position = CGPoint(x: 100, y: 200)
            //rectPoints.append(rect1.position)
            greenRects.append(rect1)
            self.addChild(rect1)
            
        }
        
        if let rect2 = self.spinnyRect?.copy() as! SKShapeNode?{
            rect2.position = CGPoint(x: 50, y: 200)
            //rectPoints.append(rect2.position)
            greenRects.append(rect2)
            self.addChild(rect2)
        }
        
        if let rect3 = self.spinnyRect?.copy() as! SKShapeNode?{
            rect3.position = CGPoint(x: 200, y: 200)
            //rectPoints.append(rect3.position)
            greenRects.append(rect3)
            self.addChild(rect3)
            
        } */
        
        
        
        
        
        
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
        
        /*if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }*/
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            
            pointList[t.hash] = [CGPoint]()
            pointList[t.hash]?.append(t.location(in: self))
            
            if t.location(in: self).y > 0 {
                p2touchHashes.append(t.hashValue)
            }
            else {
                p1touchHashes.append(t.hashValue)
            }
            //pointList[t.hash].append(t.location(in: self))
            //print(pointList[t.hash] ?? "save me from the nothing i've become")
            
           
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            pointList[t.hash]?.append(t.location(in: self))
            if !checkList(points: &(pointList[t.hash])!){
                print("Failed before closing statements")
                failure = true
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
            if good && !failure {
                let p1 = pointList[t.hash]?.first ?? CGPoint(x: 0, y: 0)
                pointList[t.hash]?.append(p1)
                if checkList(points: &(pointList[t.hash])!) {
                    let lastIndex = pointList[t.hash]!.count-1
                    pointList[t.hash]?.remove(at: lastIndex)
                    
                    let path = UIBezierPath()
                    //print("nothing is good")
                    path.move(to: (pointList[t.hash]?.first ?? CGPoint(x: 0, y: 0)))
                    for points in pointList[t.hash]!{
                        path.addLine(to: points)
                        
                    }
                    path.close()
                    //print(path)
                    let shape = SKShapeNode(path: path.cgPath)
                    
                    
                    shape.fillColor = SKColor(red:   CGFloat(Float(arc4random_uniform(255))/255.0),
                    green: CGFloat(arc4random_uniform(255))/255.0 ,
                    blue:  CGFloat(arc4random_uniform(255))/255.0 ,
                    alpha: 1.0)
                    
                    // fuck if I know
                    shape.run(SKAction.sequence([SKAction.wait(forDuration: 0.4),
                    SKAction.fadeOut(withDuration: 0.2),
                    SKAction.removeFromParent()]))
                    
                    self.addChild(shape) // add path to display

                    // lists of nodes to be merged
                    var greenRectsRemove = [SKShapeNode]()
                    var blueRectsRemove = [SKShapeNode]()
                    var redRectsRemove = [SKShapeNode]()
                    var yellowRectsRemove = [SKShapeNode]()
                    var pinkRectsRemove = [SKShapeNode]()
                    
                    var circlesRemove = [SKShapeNode]()
                    
                    // average positions of nodes to be merged
                    var greenRectAvgPos = CGPoint(x: 0,y: 0)
                    var blueRectAvgPos = CGPoint(x: 0,y: 0)
                    var redRectAvgPos = CGPoint(x: 0,y: 0)
                    var yellowRectAvgPos = CGPoint(x: 0,y: 0)
                    var pinkRectAvgPos = CGPoint(x: 0,y: 0)
                    
                    var circleAvgPos = CGPoint(x: 0,y: 0)
                    
                    // loop through objects in UI
                    for child in self.children {
                        // if node is inside path
                        if path.contains(child.position) {
                            // check if rectangle
                            for r in greenRects {
                                if child.hash == r.hash {
                                    print("Ladies and gentlemen, we got a rect")
                                    greenRectsRemove.append(child as! SKShapeNode)
                                    greenRectAvgPos = CGPoint(
                                        x: greenRectAvgPos.x + child.position.x,
                                        y: greenRectAvgPos.y + child.position.y)
                                    print(child.position)
                                }
                            }
                            
                            for r in redRects {
                                if child.hash == r.hash {
                                    print("Ladies and gentlemen, we got a rect")
                                    redRectsRemove.append(child as! SKShapeNode)
                                    redRectAvgPos = CGPoint(
                                        x: redRectAvgPos.x + child.position.x,
                                        y: redRectAvgPos.y + child.position.y)
                                    print(child.position)
                                }
                            }
                            
                            for r in blueRects {
                                if child.hash == r.hash {
                                    print("Ladies and gentlemen, we got a rect")
                                    blueRectsRemove.append(child as! SKShapeNode)
                                    blueRectAvgPos = CGPoint(
                                        x: blueRectAvgPos.x + child.position.x,
                                        y: blueRectAvgPos.y + child.position.y)
                                    print(child.position)
                                }
                            }
                            
                            for r in yellowRects {
                                if child.hash == r.hash {
                                    print("Ladies and gentlemen, we got a rect")
                                    yellowRectsRemove.append(child as! SKShapeNode)
                                    yellowRectAvgPos = CGPoint(
                                        x: yellowRectAvgPos.x + child.position.x,
                                        y: yellowRectAvgPos.y + child.position.y)
                                    print(child.position)
                                }
                            }
                            
                            for r in pinkRects {
                                if child.hash == r.hash {
                                    print("Ladies and gentlemen, we got a rect")
                                    pinkRectsRemove.append(child as! SKShapeNode)
                                    pinkRectAvgPos = CGPoint(
                                        x: pinkRectAvgPos.x + child.position.x,
                                        y: pinkRectAvgPos.y + child.position.y)
                                    print(child.position)
                                }
                            }
                            
                            
                            
                            // check if circle
                            for c in circles {
                                if child.hash == c.hash {
                                    print("Ladies and gentlemen, we got a circle")
                                    circlesRemove.append(child as! SKShapeNode)
                                    circleAvgPos = CGPoint(
                                        x: circleAvgPos.x + child.position.x,
                                        y: circleAvgPos.y + child.position.y)
                                }
                            }
                        }
                    }
                    // Calculate avg positions
                    greenRectAvgPos = CGPoint(
                        x: greenRectAvgPos.x / CGFloat(greenRectsRemove.count),
                        y: greenRectAvgPos.y / CGFloat(greenRectsRemove.count))
                    
                    blueRectAvgPos = CGPoint(
                    x: blueRectAvgPos.x / CGFloat(blueRectsRemove.count),
                    y: blueRectAvgPos.y / CGFloat(blueRectsRemove.count))
                    
                    redRectAvgPos = CGPoint(
                    x: redRectAvgPos.x / CGFloat(redRectsRemove.count),
                    y: redRectAvgPos.y / CGFloat(redRectsRemove.count))
                    
                    yellowRectAvgPos = CGPoint(
                    x: yellowRectAvgPos.x / CGFloat(yellowRectsRemove.count),
                    y: yellowRectAvgPos.y / CGFloat(yellowRectsRemove.count))
                    
                    pinkRectAvgPos = CGPoint(
                    x: pinkRectAvgPos.x / CGFloat(pinkRectsRemove.count),
                    y: pinkRectAvgPos.y / CGFloat(pinkRectsRemove.count))
                    
                    
                    circleAvgPos = CGPoint(
                        x: circleAvgPos.x / CGFloat(circlesRemove.count),
                        y: circleAvgPos.y / CGFloat(circlesRemove.count))
                    print(greenRectAvgPos)
                    print(blueRectAvgPos)
                    print(redRectAvgPos)
                    print(yellowRectAvgPos)
                    print(pinkRectAvgPos)
                    print("R Rects: \(redRectsRemove.count)")
                    print("G Rects: \(greenRectsRemove.count)")
                    print("B Rects: \(blueRectsRemove.count)")
                    print("Y Rects: \(yellowRectsRemove.count)")
                    print("P Rects: \(pinkRectsRemove.count)")
                    print("Circles: \(circlesRemove.count)")

                    var score = 0
                    
                    // multiple objects highlighted
                    if min(greenRectsRemove.count,1) + min(circlesRemove.count,1) + min(redRectsRemove.count,1) + min(blueRectsRemove.count,1) + min(yellowRectsRemove.count,1) + min(pinkRectsRemove.count,1) > 1 {
                        print("not so fast buddy")
                    }
                    // removing rects
                    else if greenRectsRemove.count > 1 {
                        score = 1
                        for _ in 2...greenRectsRemove.count {
                            score *= 10
                        }
                        print("git merge -r Grects")
                        self.removeChildren(in: greenRectsRemove) // Remove all matching rects
                        greenRectsRemove[0].position = greenRectAvgPos // Set first match to avg position
                        self.addChild(greenRectsRemove[0]) // add it back to the screen
                        let set = Set(greenRectsRemove[1..<greenRectsRemove.endIndex]) // get all elements except first (because we added it back)
                        let filtered = greenRects.filter {!set.contains($0)} // filter out all the rest
                        greenRects = filtered // set to new array
                    }
                        
                    else if blueRectsRemove.count > 1 {
                        score = 1
                        for _ in 2...blueRectsRemove.count {
                            score *= 10
                        }
                        print("git merge -r Brects")
                        self.removeChildren(in: blueRectsRemove) // Remove all matching rects
                        blueRectsRemove[0].position = blueRectAvgPos // Set first match to avg position
                        self.addChild(blueRectsRemove[0]) // add it back to the screen
                        let set = Set(blueRectsRemove[1..<blueRectsRemove.endIndex]) // get all elements except first (because we added it back)
                        let filtered = blueRects.filter {!set.contains($0)} // filter out all the rest
                        blueRects = filtered // set to new array
                    }
                    
                    else if redRectsRemove.count > 1 {
                        score = 1
                        for _ in 2...redRectsRemove.count {
                            score *= 10
                        }
                        print("git merge -r Rrects")
                        self.removeChildren(in: redRectsRemove) // Remove all matching rects
                        redRectsRemove[0].position = redRectAvgPos // Set first match to avg position
                        self.addChild(redRectsRemove[0]) // add it back to the screen
                        let set = Set(redRectsRemove[1..<redRectsRemove.endIndex]) // get all elements except first (because we added it back)
                        let filtered = redRects.filter {!set.contains($0)} // filter out all the rest
                        redRects = filtered // set to new array
                    }
                        
                    else if yellowRectsRemove.count > 1 {
                        score = 1
                        for _ in 2...yellowRectsRemove.count {
                            score *= 10
                        }
                        print("git merge -r Yrects")
                        self.removeChildren(in: yellowRectsRemove) // Remove all matching rects
                        yellowRectsRemove[0].position = yellowRectAvgPos // Set first match to avg position
                        self.addChild(yellowRectsRemove[0]) // add it back to the screen
                        let set = Set(yellowRectsRemove[1..<yellowRectsRemove.endIndex]) // get all elements except first (because we added it back)
                        let filtered = yellowRects.filter {!set.contains($0)} // filter out all the rest
                        yellowRects = filtered // set to new array
                    }
                        
                    else if pinkRectsRemove.count > 1 {
                        score = 1
                        for _ in 2...pinkRectsRemove.count {
                            score *= 10
                        }
                        print("git merge -r Prects")
                        self.removeChildren(in: pinkRectsRemove) // Remove all matching rects
                        pinkRectsRemove[0].position = pinkRectAvgPos // Set first match to avg position
                        self.addChild(pinkRectsRemove[0]) // add it back to the screen
                        let set = Set(pinkRectsRemove[1..<pinkRectsRemove.endIndex]) // get all elements except first (because we added it back)
                        let filtered = pinkRects.filter {!set.contains($0)} // filter out all the rest
                        pinkRects = filtered // set to new array
                    }
                    // removing circles
                    else if circlesRemove.count > 1 {
                        score = 1
                        for _ in 2...circlesRemove.count {
                            score *= 10
                        }
                        print("git merge -c circles")
                        self.removeChildren(in: circlesRemove) // Remove all matching circles
                        circlesRemove[0].position = circleAvgPos // Set first match to avg position
                        self.addChild(circlesRemove[0]) // add it back to the screen
                        let set = Set(circlesRemove[1..<circlesRemove.endIndex]) // get all elements except first (because we added it back)
                        
                        let filtered = greenRects.filter {!set.contains($0)} // filter out all the rest
                        circles = filtered // set to new array
                    }
                    // zero or one elements selected
                    else{
                        print("Mission failed we'll get 'em next time")
                    }
                    
                    print("I'm gonna score the players so hard")
                    
                    if p1touchHashes.contains(t.hashValue) {
                        p1score += score
                        let farray = p1touchHashes.filter {$0 != t.hashValue}
                        p1touchHashes = farray
                        p1label?.text = "Player 1 Score: \(p1score)"
                        
                        if greenRects.count < 2 ||
                            blueRects.count < 2 ||
                            redRects.count < 2 ||
                            yellowRects.count < 2 ||
                            pinkRects.count < 2 {
                            
                            let gvc = self.view?.window?.rootViewController as! GameViewController
                            gvc.gameState = GameViewController.WhoWon.Player1
                            gvc.maxPoints = p1score

                            // Load game scene?
                            if let view = self.view {
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
                    }
                    if p2touchHashes.contains(t.hashValue) {
                        p2score += score
                        let farray = p2touchHashes.filter {$0 != t.hashValue}
                        p2touchHashes = farray
                        p2label?.text = "Player 2 Score: \(p2score)"
                        
                        if greenRects.count < 2 ||
                            blueRects.count < 2 ||
                            redRects.count < 2 ||
                            yellowRects.count < 2 ||
                            pinkRects.count < 2 {
                            
                            let gvc = self.view?.window?.rootViewController as! GameViewController
                            gvc.gameState = GameViewController.WhoWon.Player2
                            gvc.maxPoints = p2score

                            // Load game scene?
                            if let view = self.view {
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
                    }
                    
                    print("P1 score = \(p1score), P2 score = \(p2score)")
                    
                    /*for rect in rectPoints{
                        print(rect)
                    }*/
                    
                    //print("Pointslist")
                    //print(pointList[t.hash]!)
                    pointList[t.hash] = nil // clear out point list
                }
            }
            
            if failure {
                print("Failure")
                failure = false
            }
            
            if !good {
                print("Bad path detected")
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
