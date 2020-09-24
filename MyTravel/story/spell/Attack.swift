//
//  Attack.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/6.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Attack: Spell {
    override func cast(completion: @escaping () -> Void) {
//        let target = findTargetByOrder()
        let b = Game.curBattle!
        let target = _targets[0]
        let source = b._curUnit!
        
        let dmg = getPhysicalDamage(source: source, target: target).valueDefend()
        source.actionAttack {
            target.actionAttacked {
                target.showValue(dmg: dmg, completion: completion)
            }
        }
    }
}
