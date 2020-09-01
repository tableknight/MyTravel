//
//  BattleUnit.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/16.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class BattleUnit: ActionUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

