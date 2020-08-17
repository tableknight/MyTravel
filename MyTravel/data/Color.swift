//
//  Color.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit

struct QualityColor {
    static let NORMAL = UIColor.white
    static let GOOD = UIColor.green
    static let RARE = UIColor.init(red: 0.2, green: 0.53, blue: 1, alpha: 1)
    static let SACRED = UIColor.init(red: 1, green: 0.137, blue: 0.137, alpha: 1)
    static func getColor(_ q:Int) -> UIColor {
        switch q {
        case Quality.NORMAL:
            return NORMAL
        case Quality.GOOD:
            return GOOD
        case Quality.RARE:
            return RARE
        case Quality.SACRED:
            return SACRED
        default:
            return NORMAL
        }
    }
}
struct DamageColor {
    static let DAMAGE = UIColor.init(red: 1, green: 0.137, blue: 0.137, alpha: 1)
    static let HEAL = UIColor.green
    static let NORMAL = UIColor.white
    static let MAGICAL = UIColor.init(red: 1, green: 0.137, blue: 0.137, alpha: 1)
    static let FIRE = UIColor.orange
    static let WATER = UIColor.init(red: 0.2, green: 0.53, blue: 1, alpha: 1)
    static let THUNDER = UIColor.yellow
}
