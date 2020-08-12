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
        let scene = Scene()
        for x in 0...Size.default_cell_x_count {
            for y in 0...Size.default_cell_y_count {
                scene.addCell(x: x, y: y, item: s.getNode(0, 0))
            }
        }
        scene.addCell(x: 0, y: Size.default_cell_y_count / 2, item: s.getNode(5, 0))
        scene.addCell(x: 0, y: 0, item: s.getNode(5, 0))
        scene.addCell(x: Size.default_cell_x_count / 2, y: 0, item: s.getNode(5, 0))
        scene.addCell(x: Size.default_cell_x_count, y: 0, item: s.getNode(5, 0))
        scene.addCell(x: Size.default_cell_x_count, y: Size.default_cell_y_count, item: s.getNode(5, 0))
        scene.addCell(x: Size.default_cell_x_count / 2, y: Size.default_cell_y_count / 2, item: s.getNode(5, 0))
//        scene.addCell(x: Size.default_cell_x_count / 2 - 1, y: Size.default_cell_y_count / 2, item: s.getNode(0, 0))
//        scene.addCell(x: Size.default_cell_x_count / 2 - 2, y: Size.default_cell_y_count / 2, item: s.getNode(0, 0))
//        scene.addCell(x: Size.default_cell_x_count / 2 + 1, y: Size.default_cell_y_count / 2, item: s.getNode(0, 0))
//        scene.addCell(x: Size.default_cell_x_count / 2 + 2, y: Size.default_cell_y_count / 2, item: s.getNode(0, 0))
        let stage = Stage()
        stage.loadScene(scene: scene)
        stage.setRole(role: ActionUnit())
        addChild(stage)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
