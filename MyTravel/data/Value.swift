//
//  Value.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
// ui > 遮挡部分roof > 角色role > 物品部分item
struct ZIndex {
    static let role:CGFloat = 1000
    static let ground:CGFloat = 10
    static let portal:CGFloat = 20
    static let enemy:CGFloat = 500
    static let shadow:CGFloat = 300
    static let item:CGFloat = 100
    static let roof:CGFloat = 2000
    static let ui:CGFloat = 5000
    static let panel:CGFloat = 15000
}
let LandFragment:Array<Array<Int>> = [
    [0,0,1,0,0,2,2,2], // x,y,x,y,x,y,x,y
    [1,0,2,0,0,1,2,2],
    [0,0,2,0,0,1],
    [0,1,1,1,0,2],
    [0,0,0,1,1,1],
    [0,0,1,2,2,2],
    [1,1,2,1,2,2],
    [2,0,2,1,0,2],
    [0,0,2,1,1,2,2,2],
    [2,0,0,1,0,2,1,2],
    [0,0,2,1,0,2],
    [0,0,2,0,0,1,1,2],
]
struct Cell {
    static let empty = 10
    static let wall = 11
    static let enemy = 12
    static let portal = 13
    static let herb = 14
    static let chest = 15
    static let tower = 16
}
struct DamageType {
    static let PHYSICAL = 1
    static let MAGICAL = 2
    static let FIRE = 3
    static let WATER = 4
    static let THUNDER = 5
    static let FWMIXED = 34 //冰火混合
}
struct Quality {
    static let NORMAL = 1
    static let GOOD = 2
    static let RARE = 3
    static let SACRED = 4
}
struct Value {
    static let village_name = "贝鲁特"
    static let border_radius:CGFloat = 8
    static let unselected_stroke_color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
    static let selected_stroke_color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
    static let selected_stroke_width:CGFloat = 2
    static let unselected_stroke_width:CGFloat = 1.5
    static let background_alpha:CGFloat = 0.8
    static let transparent_color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)
}
struct Direction {
    var north = false
    var south = false
    var east = false
    var west = false
}
struct EvilType {
    static let RISEN = 1
    static let MAN = 2
    static let ANGEL = 3
    static let DEMON = 4
    static let NATURE = 5
    static let BOSS = 6
    static let GIANT = 7
    static func getTypeLabel(type:Int) -> String {
        switch type {
        case EvilType.RISEN:
            return "亡灵"
        case EvilType.ANGEL:
            return "天使"
        case EvilType.MAN:
            return "人类"
        case EvilType.NATURE:
            return "生灵"
        case EvilType.DEMON:
            return "恶魔"
        case EvilType.GIANT:
            return "巨人"
        default:
            return "人类"
        }
    }
}
