//
//  GameScene.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        addChild(getCross())
        let s = SKTexture(imageNamed: "Outside")
        let scene = TwistedMeadow()
        scene.addBoundCells()
        let node = s.getNode(12, 1, 2, 4)
        scene._groundNode = node
        scene.create()
        let stage = Stage()
        stage.loadScene(scene: scene)
        stage.setRole(ActionUnit())
        addChild(stage)
        
//        let node = WallNodeTree()
//        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        addChild(node)
//        let node1 = EnemyNode()
//        node1.setRole(node: SKTexture(imageNamed: "green_spirit").getNode(0, 1))
//        addChild(node1)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchPoint = touches.first?.location(in: self)
//        print(touchPoint!)
//        print(touchPoint!.x.toInt() - Size.default_cell_x_count * 18)
//        print(touchPoint!.y.toInt() + Size.default_cell_y_count * 18)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
