//
//  EnemyNode.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/6.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class EnemyNode: ActionUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent(completion:@escaping () -> Void = {}) {
        let sc = Game.curStage._curScene as! Dungeon
        let b = Battle()
        var es = Array<Creature>()
        var nums = [1,1,2,2,3,3,3,3,3,4,4,4,5].one()
        if sc._level <= 3 {
            nums = [1,1,1,1,0,0].one()
        } else if sc._level < 10 {
            nums = [0,1,1,1,2,2,2,2,2,3,3].one()
        }
        let l = sc._level.toFloat()
        for _ in 0...nums {
            let u = Creature(sc._enemyType.one())
            u.create(level: seed() < 5 ? 1 : [l > 1 ? l - 1 : 1, l , l + 1].one())
            es.append(u)
        }
        b.setEnemies(parts: es)
        b.start()
        b.victoryAction = {
            completion()
        }
    }
}
