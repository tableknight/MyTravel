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
            FieldData(battleX: 0, battleY: 0, displayX: cs * 1.9, displayY: -cs * 0.25, starName: "人马座ε", index: 1, desc: "提升5%命中"),
            FieldData(battleX: 0, battleY: 0, displayX: cs * 1.65, displayY: cs * 1.65, starName: "人马座λ", index: 2, desc: "提升5%攻击"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 0.5, displayY: cs * 0.65, starName: "人马座α", index: 3, desc: "提升5%物理伤害"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.82, displayY: cs * 0, starName: "人马座ζ", index: 4, desc: "提升10%火焰抵抗"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.75, displayY: -cs * 1.1, starName: "人马座δ", index: 5, desc: "提升10%冰冷抵抗"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 1.5, displayY: -cs * 2, starName: "人马座β", index: 6, desc: "提升10%雷电抵抗")
        ],
        Field.Libra: [
            FieldData(battleX: 0, battleY: 0, displayX: cs * 1.8, displayY: -cs * 0.7, starName: "天秤座α", index: 1, desc: "提升5%力量"),
            FieldData(battleX: 0, battleY: 0, displayX: cs * 2.3, displayY: cs * 1.45, starName: "天秤座β", index: 2, desc: "提升5%耐力"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 0.65, displayY: cs * 0.95, starName: "天秤座σ", index: 3, desc: "减少5%智力"),
            FieldData(battleX: 0, battleY: 0, displayX: -cs * 2.25, displayY: cs * 0.4, starName: "天秤座δ", index: 4, desc: "提升10复仇"),
            FieldData(battleX: 0, battleY: 0, displayX: cs * 0.35, displayY: -cs * 2.55, starName: "天秤座μ", index: 5, desc: "提升10律动"),
            FieldData(battleX: 0, battleY: 0, displayX: cs * 0.35, displayY: cs * 2.55, starName: "天秤座ι", index: 6, desc: "提升10法术亲和")
        ]
    ]
}

