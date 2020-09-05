//
//  ArmorData.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/3.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
struct ArmorData {
    var type = ""
    var name = ""
    var desc = ""
    var attackSpeedMax = -1
    var attackSpeedMin = -1
    var baseAttrs = Array<Int>()
    static let data = [
        Armor.Wand: ArmorData(type: Armor.Wand, name: "法杖", desc: "", attackSpeedMax: 100, attackSpeedMin: 70, baseAttrs: [Attribute.INTELLECT]),
        Armor.Bow: ArmorData(type: Armor.Bow, name: "弓", desc: "", attackSpeedMax: 130, attackSpeedMin: 100, baseAttrs: [Attribute.ATTACK_BASE, Attribute.AGILITY]),
        Armor.Blunt: ArmorData(type: Armor.Blunt, name: "钝器", desc: "", attackSpeedMax: 100, attackSpeedMin: 70, baseAttrs: [Attribute.ATTACK_BASE, Attribute.STAMINA]),
        Armor.Sword: ArmorData(type: Armor.Sword, name: "剑", desc: "", attackSpeedMax: 120, attackSpeedMin: 90, baseAttrs: [Attribute.ATTACK_BASE, Attribute.STRENGTH]),
        Armor.Instrument: ArmorData(type: Armor.Instrument, name: "法器", desc: "", attackSpeedMax: 100, attackSpeedMin: 100, baseAttrs: [Attribute.SPIRIT_BASE]),
        Armor.Fist: ArmorData(type: Armor.Fist, name: "拳套", desc: "", attackSpeedMax: 130, attackSpeedMin: 100, baseAttrs: [Attribute.ATTACK, Attribute.BREAK]),
        Armor.Dagger: ArmorData(type: Armor.Dagger, name: "匕首", desc: "", attackSpeedMax: 150, attackSpeedMin: 120, baseAttrs: [Attribute.ATTACK, Attribute.AVOID]),
        Armor.MagicMark: ArmorData(type: Armor.MagicMark, name: "魔印", desc: "", baseAttrs: []),
        Armor.SoulStone: ArmorData(type: Armor.SoulStone, name: "灵魂石", desc: "", baseAttrs: []),
        Armor.Shield: ArmorData(type: Armor.Shield, name: "盾", desc: "", baseAttrs: [Attribute.DEFENCE]),
        Armor.Ring: ArmorData(type: Armor.Ring, name: "戒指", desc: "", baseAttrs: []),
        Armor.Amulet: ArmorData(type: Armor.Amulet, name: "项链", desc: "", baseAttrs: [Attribute.HIT_POINT]),
        Armor.EarRing: ArmorData(type: Armor.EarRing, name: "耳环", desc: "", baseAttrs: [Attribute.MAGICAL_POWER])
    ]
}
