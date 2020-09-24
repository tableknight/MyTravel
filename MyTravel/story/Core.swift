//
//  Core.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
func seed(min:Int = 0, max:Int = 101) -> Int {
    return Int(arc4random_uniform(UInt32(max - min))) + min
}
func seedFloat(min:Int = 0, max:Int = 101) -> CGFloat {
    return seed(min: min, max: max).toFloat()
}
func debug(_ s:String) {
    print(s)
}
class Core:NSObject, Codable{
    override init() {
        super.init()
    }
    static func getSpellById(id:Int) -> Spell {
        switch id {
        case Spell.LowerFlame:
            return LowerFlame()
        default:
            return LowerFlame()
        }
    }

    
}
class ErrorSpell: Spell {
    override init() {
        super.init()
        _name = "ErrorSpell"
        debug("ErrorSpell")
    }
}


