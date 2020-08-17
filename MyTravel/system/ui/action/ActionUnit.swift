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
        _texture = SKTexture(imageNamed: "test_role")
        setRole(node: _texture.getNode(1, 2))
        _roleNode.position.y = cellSize * 0.125
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
