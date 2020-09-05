//
//  FieldData.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
let cs = Size.display_cell_size
struct FieldData {
    var battleX:CGFloat = 0
    var battleY:CGFloat = 0
    var displayX:CGFloat = 0
    var displayY:CGFloat = 0
    var starName = ""
    var index = 0
    var desc = ""
    static let data = [
        Field.Sagittarius: [
            FieldData(battleX: 0, battleY: 0, displayX: cs * 1.45, displayY: cs * 1.25, starName: "人马座λ", index: 1, desc: "提升5%攻击"),
            FieldData(battleX: 0, battleY: 0, displayX: cs * 2, displayY: -cs * 0.2, starName: "人马座ε", index: 2, desc: "提升5%命中"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 0.2, displayY: 0, starName: "人马座α", index: 3, desc: "减少5%物理伤害"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.4, displayY: cs * 0.5, starName: "人马座ζ", index: 4, desc: "提升10%火焰抵抗"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.7, displayY: -cs * 1.1, starName: "人马座δ", index: 5, desc: "提升10%冰冷抵抗"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.4, displayY: -cs * 2.5, starName: "人马座β", index: 6, desc: "提升10%雷电抵抗")
        ]
    ]
}

