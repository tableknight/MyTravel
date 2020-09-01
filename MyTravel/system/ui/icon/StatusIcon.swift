//
//  StatusIcon.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class StatusIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        mustShowCount = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
