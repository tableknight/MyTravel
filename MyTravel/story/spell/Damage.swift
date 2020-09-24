//
//  Damage.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/6.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Damage {
    static let type_fire = 1
    static let type_magical = 2
    static let type_physical = 3
    static let type_water = 4
    static let type_thunder = 5
    var _target:BattleUnit!
    var _source:BattleUnit!
    var _value:CGFloat = 0
    var _type = Damage.type_physical
    var isHeal = false
    var isDefend = false
    func valueDefend() -> Damage {
        if _target.isDefend {
            _value = seedFloat(min: 1, max: (_value / 2).toInt())
        }
        return self
    }
}
