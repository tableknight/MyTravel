//
//  ItemIcon.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/16.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ItemIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        selected = false
        mustShowCount = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
