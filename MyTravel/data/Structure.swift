//
//  Structure.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/13.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
struct Main:Codable {
    var strength:CGFloat = 0
    var agility:CGFloat = 0
    var intellect:CGFloat = 0
}
struct Extended:Codable {
    var attack:CGFloat
    var defence:CGFloat
    var speed:CGFloat
    var accuracy:CGFloat
    var critical:CGFloat
    var avoid:CGFloat
    var spirit:CGFloat
    var hitPoint:CGFloat
    var hitPointMax:CGFloat
    var mana:CGFloat
    var manaMax:CGFloat
}

struct Extra:Codable {
    var lucky:CGFloat
    var pennetrate:CGFloat
    var revenge:CGFloat
    var destory:CGFloat
    var rhythm:CGFloat
    var power:CGFloat
}
struct Natrual:Codable {
    var fire:CGFloat
    var water:CGFloat
    var thunder:CGFloat
}