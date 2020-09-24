//
//  LowerFlame.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/16.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class LowerFlame: Spell {
    override init() {
        super.init()
        _id = Spell.LowerFlame
        _name = "低阶火焰"
        _description = "对目标造成精神60%的火焰伤害"
        _rate = 0.6
        _quality = Quality.NORMAL
        _cd = 0
        _manaCost = 5 * _costRate
        autoCast = false
    }
    override func cast(completion:@escaping () -> Void) {
        let c = Game.curBattle._curUnit!
        let t = _targets[0]
        let dmg = getFireDamage(source: c, target: t)
        if c.amuletIs(Sacred.LavaCrystal) {
            _rate = 1.1
        }
        c.actionCast {
            t.actionAttacked {
                t.showValue(dmg: dmg, completion: completion)
            }
            t.hitFire()
        }
    }
   
}

