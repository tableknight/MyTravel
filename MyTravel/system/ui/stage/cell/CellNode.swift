//
//  CellNode.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/15.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class CellNode: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal func setTexture(_ texture:SKTexture) {
        self.texture = texture
//        self.size = texture.size()
    }
    internal func setSize(w:CGFloat, h:CGFloat) {
        self.size = CGSize(width: w * cellSize, height: h * cellSize)
    }
    func triggerEvent() {
        
    }
    var _key = ""
    var _triggered = false
}

class RoleNode: CellNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize, height: cellSize)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setRole(node:SKSpriteNode) {
        node.zPosition = ZIndex.enemy
        node.anchorPoint.y = 0
        node.size = CGSize(width: cellSize, height: cellSize)
        addChild(node)
        _roleNode = node
        let shadow = SKSpriteNode(imageNamed: "shadow")
        shadow.zPosition = ZIndex.shadow
        _roleNode.addChild(shadow)
    }
    internal var _roleNode:SKSpriteNode!
    internal var _texture:SKTexture!
    var _unit:Unit!
}

class EnemyNode: RoleNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class WallNode:CellNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        setTexture(SKTexture(imageNamed: "Outside_B").getNode(9, 11, 1, 2).toTexture())
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addTopNode(node: SKSpriteNode) {
        node.zPosition = ZIndex.roof
        node.anchorPoint.y = 0
        node.position.y = cellSize
        addChild(node)
    }
    func addBottomNode(node: SKSpriteNode) {
        node.zPosition = ZIndex.item
        node.anchorPoint.y = 0
        addChild(node)
    }
}
class WallNodeTree:WallNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ob = SKTexture(imageNamed: "Outside_B")
        self.size = CGSize(width: cellSize, height: cellSize * 2)
        addTopNode(node: ob.getNode(5, 11))
        addBottomNode(node: ob.getNode(5, 12))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
