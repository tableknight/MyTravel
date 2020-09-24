//
//  ActionUnit.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ActionUnit: RoleNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _texture = SKTexture(imageNamed: "test_role")
//        setRole(node: _texture.getNode(1, 2))
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showText(text:String, color:UIColor = UIColor.white, completion:@escaping () -> Void) {
        let label = Label()
        label.align = "center"
        label.text = text
        label.fontSize = cellSize / 3
        label.y = cellSize * 0.75
        label.fontColor = color
        label.zPosition = ZIndex.topest
        addChild(label)
////        label.
        let v = CGVector(dx: 0, dy: cellSize / 2)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move, wait])
        label.run(go) {
            label.removeFromParent()
            completion()
        }
    }
    func actionDead(completion:@escaping () -> Void) {
        let fade = SKAction.fadeOut(withDuration: TimeInterval(0.75))
        _roleNode.run(fade) {
            completion()
        }
    }
    func actionCast(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let fadeout = SKAction.fadeOut(withDuration: TimeInterval(0.15))
        let fadein = SKAction.fadeIn(withDuration: TimeInterval(0.15))
        let go = SKAction.sequence([wait,fadeout,fadein,fadeout,fadein,fadeout,fadein, SKAction.wait(forDuration: TimeInterval(0.15))])
        setTimeout(delay: 0.5, completion: {
            //                Sound.play(node: self, fileName: "cast")
        })
        _roleNode.run(go) {
            completion()
        }
    }
    func faceSouth() {
        _roleNode.texture = _texture.getCell(1, 0)
    }
    func faceNorth() {
        _roleNode.texture = _texture.getCell(1, 3)
    }
    func faceWest() {
        _roleNode.texture = _texture.getCell(1, 1)
    }
    func faceEast() {
        _roleNode.texture = _texture.getCell(1, 2)
    }
    internal var _wait = SKAction.wait(forDuration: TimeInterval(Game.frame_size))
    func moveNorth(completion:@escaping () -> Void = {}) {
        let move1 = SKAction.setTexture(_texture.getCell(0, 3))
        let move2 = SKAction.setTexture(_texture.getCell(2, 3))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        let move = SKAction.move(by: CGVector(dx: 0, dy: cellSize), duration: TimeInterval(Game.frame_size * 2))
        let anime = SKAction.group([move, go])
        _roleNode.run(anime) {
            completion()
        }
    }
    
    func moveSouth(completion:@escaping () -> Void = {}) {
        let move1 = SKAction.setTexture(_texture.getCell(0, 0))
        let move2 = SKAction.setTexture(_texture.getCell(2, 0))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        let move = SKAction.move(by: CGVector(dx: 0, dy: -cellSize), duration: TimeInterval(Game.frame_size * 2))
        let anime = SKAction.group([move, go])
        _roleNode.run(anime) {
            completion()
        }
    }
    func moveWestSlience() {
        let move1 = SKAction.setTexture(_texture.getCell(0, 1))
        let move2 = SKAction.setTexture(_texture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        _roleNode.run(go)
    }
    func moveWest(completion:@escaping () -> Void = {}) {
        let move1 = SKAction.setTexture(_texture.getCell(0, 1))
        let move2 = SKAction.setTexture(_texture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        let move = SKAction.move(by: CGVector(dx: -cellSize, dy: 0), duration: TimeInterval(Game.frame_size * 2))
        let anime = SKAction.group([move, go])
        _roleNode.run(anime) {
            completion()
        }
    }
    func moveEastSlience() {
        let step1 = SKAction.setTexture(_texture.getCell(0, 2))
        let step2 = SKAction.setTexture(_texture.getCell(2, 2))
        let go = SKAction.sequence([step1, _wait, step2, _wait])
        _roleNode.run(go)
    }
    func moveEast(completion:@escaping () -> Void = {}) {
        let step1 = SKAction.setTexture(_texture.getCell(0, 2))
        let step2 = SKAction.setTexture(_texture.getCell(2, 2))
        let move = SKAction.move(by: CGVector(dx: cellSize, dy: 0), duration: TimeInterval(Game.frame_size * 2))
        let go = SKAction.sequence([step1, _wait, step2, _wait])
        let anime = SKAction.group([move, go])
        _roleNode.run(anime) {
            completion()
        }
    }
    
}
