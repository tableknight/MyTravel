//
//  Chest.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/18.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Chest:CellNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let texture = SKTexture(imageNamed: "Chest")
        let item = texture.getCell(0, 0)
        setTexture(item)
        setSize(w: 1, h: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
//        if _triggered {
//            return
//        }
//        _triggered = true
//        let item = Game.instance.pictureChest.getCell(_x.toFloat(), 3)
//        setTexture(item)
//        Sound.play(node: Game.instance.curStage, fileName: "chest")
//        if Core().d4() {
//            let b = MimicBattle()
//            b._level = Game.instance.curStage._curScene._level
//            b.setEnemyPart(minions: Array<Creature>())
//            let char = Game.instance.char!
//            let cs:Array<Unit> = [char] + char.getReadyMinions()
//            b.setPlayerPart(roles: cs)
//            Game.instance.curStage.addBattle(b)
//            b.battleStart()
//
//            b.victoryAction = {
//                let l = Loot()
//                let roles = b._playerPart
//                for c in roles {
//                    let exp = l.getExp(selfUnit: c, enemyLevel: Game.instance.curStage._curScene._level) * 10
//                    c._unit.expUp(up: exp)
//                }
//            }
//            return
//        }
//
//        loot()
        
    }
    
}
