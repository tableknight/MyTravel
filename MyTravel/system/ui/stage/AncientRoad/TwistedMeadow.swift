//
//  TwistedMeadow.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/13.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class TwistedMeadow: Dungeon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "秘境沼泽"
        _id = AncientRoad.TWISTED_MEADOW
        _soundUrl = "secret_meadow"
        _groundNode = SKTexture(imageNamed: "Outside").getNode(12, 1, 2, 4)
        _enemyType = [
            Creature.GreenSpirit,
            Creature.Luki,
            Creature.TreeSpirit,
            Creature.Fairy
        ]
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
