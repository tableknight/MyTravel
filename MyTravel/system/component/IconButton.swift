//
//  IconButton.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/23.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit

class IconButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(index:CGFloat, text:String) {
        let icon = SKTexture(imageNamed: "icons").getNode(index, 0)
        addChild(icon)
        let label = Label()
        label.text = text
        label.position.y = -cellSize * 0.75
        label.fontSize = 12
        label.align = "center"
        addChild(label)
    }
}
