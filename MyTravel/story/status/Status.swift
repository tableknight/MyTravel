//
//  Status.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/18.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Status:Core {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    var _labelText = ""
    var _timeleft:Int = 3
    var _type:String = ""
    var _name = ""
    var _description = ""
    var _img = SKTexture()
//    var _source = BUnit()
    var timeupAction = {}
    var inEndOfRound = {}
    static let TURN_ATTACK = "turn_status"
    static let ATTACK_RETURN_BACK = "attack_return_back"
    static let FREEZING = "freezing"
    static let FRAGILE = "fragile"
    static let TAUNTED = "taunted"
    static let VAMPIRE_BLOOD = "vampire_blood"
    static let CRAZY = "crazy"
    static let DANCING_ON_ICE = "dancing_on_ice"
    static let BARGE_ABOUTR = "barge_about"
    static let BLOOD_THIRSTY = "blood_thirsty"
    static let ARMATURE_PUPPET = "armature_puppet"
    static let MIGHT_OF_OAKS = "might_of_oaks"
    static let BELLICOSE = "bellicose"
    static let CRUEL = "cruel"
    static let REBORN = "reborn"
    static let CONFUSED = "Confused"
    static let RACE_SUPERIORITY = "race_superiorty"
    static let PROTECT_FROM_GOD = "protect_from_god"
    static let PROTECTION_FROM_ICE = "protection_from_ice"
    static let FIRE_LORD = "fire_lord"
    static let FOCUS = "focus"
    static let ONE_PUNCH = "one_punch"
    static let MAGIC_SWORD = "magic_sword"
    static let EYE_TO_EYE = "eye_to_eye"
    static let TURN_MAGIC = "turn_magic"
    static let DEATH_STRIKE_UP = "death_strike_up"
    static let DEATH_STRIKE_DOWN = "death_strike_down"
    static let DISAPPEAR = "disappear"
    static let ICE_SHIELD = "ice_shield"
    static let ICE_GUARD = "ice_guard"
    static let LOST_SEPPD = "lost_speed"
    static let IMMUNE = "immune"
    static let DOMINATE = "dominate"
    static let BURNING = "burning"
    static let INFECTED = "infected"
    static let PETRIFY = "petrify"
    
    static let FIRE_ENERGE = "fire_energe"
    static let WATER_ENERGE = "water_energe"
    static let THUNDER_ENERGE = "thunder_energe"
    static let TIME_REDUCE = "time_reduce"
    static let PHYSICAL_POWER = "physical_power"
    static let MAGICAL_POWER = "magical_power"
    static let ATTACK_POWER = "attack_power"
    static let DEFENCE_POWER = "defence_power"
    static let MIND_POWER = "mind_power"
    static let LUCKY_POWER = "lucky_power"
    static let SPEED_POWER = "speed_power"
    static let ICE_BOMB = "ice_bomb"
    static let MAKE_EVERYTHING_RIGHT = "make_everything_right"
    static let NERVOUS_POISON = "nervous_poison"
    static let SOUL_SLAY = "soul_slay"
    
    var hasBeforeMoveAction = false
    var _castSpell:Spell!
}
class LostSpeed:Status {
    override init() {
        super.init()
        _type = Status.LOST_SEPPD
        let this = self
        timeupAction = {
//            this._source._valueUnit._extensions.speed += 10
//            debug("速度恢复")
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class BurningStatus:Status {
    override init() {
        super.init()
        _type = Status.BURNING
//        timeupAction = {}
        _labelText = "B"
        _timeleft = 3
        hasBeforeMoveAction = true
    }
//    var _level:CGFloat = 1
//    func getBurningDamage(unit:BUnit) -> CGFloat {
//        var rate:CGFloat = 0.05
//        if unit._unit is Boss {
//            rate = 0.015
//        }
//        let damage = unit.getHealth() * rate
//        return -damage * _level
//    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

