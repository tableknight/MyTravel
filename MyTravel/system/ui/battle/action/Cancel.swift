//
//  Cancel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/13.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Cancel: Spell {
    override init() {
        super.init()
    }
    override func cast(completion: @escaping () -> Void) {
        let c = Game.curBattle._curUnit!
        c.isDefend = true
        c.showText(text: "防御", completion: {
            setTimeout(delay: 0.5, completion: completion)
        })
    }
}
