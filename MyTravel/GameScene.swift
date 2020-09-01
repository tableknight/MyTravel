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
//        addChild(getCross())
        let s = SKTexture(imageNamed: "Outside")
        let scene = TwistedMeadow()
//        scene.addBoundCells()
        let node = s.getNode(12, 1, 2, 4)
        scene._groundNode = node
        scene.create()
        let stage = Stage()
        Game.curStage = stage
        stage.loadScene(scene: scene)
        stage.setRole(ActionUnit())
//        addChild(stage)
//
//        let c = Creature()
//        c.levelTo(level: 10)
//        c._name = "大黄蜂"
//
//        let p = RolePanel()
//        p.create(unit: c)
//        stage.showPanel(p)
        
        let sw = StatusWindow()
        sw.create(description: "")
        sw.x = 200
        addChild(sw)
        
        
//        let i = Icon()
//        i.iconText = "弓箭"
//        i.count = 10
//        i.quality = Quality.SACRED
//        addChild(i)
        
//        let unit = Unit()
//        unit._name = "艾米丽"
//        unit._imgUrl = "test_role"
////        unit._img = SKTexture(imageNamed: "test_role")
//
//        let t = Thumb()
//        t.quality = Quality.SACRED
//        t.create(unit: unit)
//        addChild(t)
        
//        let lvWidth = cellSize * 0.5
//               let lvCircle = LvCircle()
//               lvCircle.create(radius: lvWidth, value: 12)
////               lvCircle.position = CGPoint(x: -deviceSize.width * 0.5 + lvWidth * 2, y: deviceSize.height * 0.5 - cellSize * 0.5)
//               addChild(lvCircle)
        
        
        
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
