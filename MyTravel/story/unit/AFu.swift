//
//  AFu.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/6.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class AFu: Creature {
    override init() {
        super.init()
        _stars.stamina = 2.6
        _stars.strength = 1.5
        _stars.agility = 0.6
        _stars.intellect = 1.1
        _spellCount = 1
        _name = "阿福"
        _imgUrl = "afu"
        _race = EvilType.NATURE
    }
    override func create(level: CGFloat) {
        _level = level
        _quality = Quality.NORMAL
        _growth.stamina = _stars.stamina
        _growth.strength = _stars.strength
        _growth.agility = _stars.agility
        _growth.intellect = _stars.intellect
        _birth.stamina = 15
        _birth.strength = 15
        _birth.agility = 15
        _birth.intellect = 15
        levelTo(level: level)
        _extended.hitPoint = _extended.hitPointMax
        createSensitive()
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

