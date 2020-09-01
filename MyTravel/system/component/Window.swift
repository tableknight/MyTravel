//
//  Window.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/1.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Window: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _backgroundNode = createBackground(width: _width, height: _height)
//        _backgroundNode.fillColor = Value.transparent_color
//        addChild(_backgroundNode)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(item:Showable) {
        
    }
    internal var _backgroundNode: SKShapeNode!
}
