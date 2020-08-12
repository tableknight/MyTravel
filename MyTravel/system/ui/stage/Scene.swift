//
//  Scene.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Scene: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addChild(_groundLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addCell(x:Int, y:Int, item:SKSpriteNode, z:CGFloat = 0) {
//            item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-_xSize / 2 + x).toFloat() * cellSize
            item.position.y = (_ySize / 2 - y).toFloat() * cellSize
            if z > 0 {
                item.zPosition = z
            }
    //        item.name = getItemName(CGPoint(x: x, y: y))
        _groundLayer.addChild(item)
        }
    internal var _xSize = Size.default_cell_x_count
    internal var _ySize = Size.default_cell_y_count
    internal var _groundLayer = SKSpriteNode()
}
