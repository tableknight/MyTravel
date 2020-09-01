//
//  Unit.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/13.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Unit:NSObject, Codable {
    override init() {
        super.init()
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
//    private enum CodingKeys: String, CodingKey {
//        case _main
//        case _extended
//        case _extra
//        case _level
//        case _name
//        case _race
//        case _exp
//        case _spellCount
//        case _leftPoint
//        case _spells
//        case _spellsInuse
//        case _spellsHidden
//        case _imgUrl
//        case _seat
//        case _quality
//        case _NatrualPower
//        case _NatrualResistance
//        case _magical
//        case _Natrual
//        case _physical
//    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        _main = try values.decode(Main.self, forKey: ._main)
//        _extended = try values.decode(Extended.self, forKey: ._extended)
//        _extra = try values.decode(Extra.self, forKey: ._extra)
//        _level = try values.decode(CGFloat.self, forKey: ._level)
//        _name = try values.decode(String.self, forKey: ._name)
//        _race = try values.decode(Int.self, forKey: ._race)
//        _exp = try values.decode(CGFloat.self, forKey: ._exp)
//        _spellCount = try values.decode(Int.self, forKey: ._spellCount)
//        _leftPoint = try values.decode(Int.self, forKey: ._leftPoint)
//        _spells = try values.decode(Array.self, forKey: ._spells)
//        _spellsInuse = try values.decode(Array.self, forKey: ._spellsInuse)
//        _spellsHidden = try values.decode(Array.self, forKey: ._spellsHidden)
//        _imgUrl = try values.decode(String.self, forKey: ._imgUrl)
//        _seat = try values.decode(String.self, forKey: ._seat)
//        _quality = try values.decode(Int.self, forKey: ._quality)
//        _NatrualPower = try values.decode(Natrual.self, forKey: ._NatrualPower)
//        _NatrualResistance = try values.decode(Natrual.self, forKey: ._NatrualResistance)
//        if _imgUrl.isEmpty {
//            _imgUrl = "test_role"
//        }
//        _img = SKTexture(imageNamed: _imgUrl)
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(_main, forKey: ._main)
//        try container.encode(_extended, forKey: ._extended)
//        try container.encode(_extra, forKey: ._extra)
//        try container.encode(_level, forKey: ._level)
//        try container.encode(_name, forKey: ._name)
//        try container.encode(_race, forKey: ._race)
//        try container.encode(_exp, forKey: ._exp)
//        try container.encode(_spellCount, forKey: ._spellCount)
//        try container.encode(_leftPoint, forKey: ._leftPoint)
//        try container.encode(_spells, forKey: ._spells)
//        try container.encode(_spellsInuse, forKey: ._spellsInuse)
//        try container.encode(_spellsHidden, forKey: ._spellsHidden)
//        try container.encode(_imgUrl, forKey: ._imgUrl)
//        try container.encode(_seat, forKey: ._seat)
//        try container.encode(_quality, forKey: ._quality)
//        try container.encode(_NatrualPower, forKey: ._NatrualPower)
//        try container.encode(_NatrualResistance, forKey: ._NatrualResistance)
//        try super.encode(to: encoder)
//    }
    
    var _main = Main(strength: 0, agility: 0, intellect: 0)
    var _extended = Extended(attack: 40, defence: 20, speed: 0, accuracy: 100, critical: 15, avoid: 20, spirit: 40, hitPoint: 100, hitPointMax: 100, mana: 100, manaMax: 100)
    var _extra = Extra(lucky: 0, pennetrate: 0, revenge: 0, destory: 0, rhythm: 0, power: 0)
    var _level:CGFloat = 1
    var _name:String = ""
    var _race:Int = 0
    var _exp:CGFloat = 0
    var _spellCount = 1
    var _leftPoint:Int = 0
    var _spells = Array<Int>()
    var _spellsInuse = Array<Int>()
    var _spellsHidden = Array<Int>()
    
    
//    var _img:SKTexture!
    var _imgUrl:String = ""
    
    var _seat = ""
    var _quality:Int = Quality.NORMAL
    
    var _NatrualPower = Natrual(
        fire : 0,
        water : 0,
        thunder : 0
    )
    
    var _NatrualResistance = Natrual(
        fire : 0,
        water : 0,
        thunder : 0
    )
    func expUp(up:CGFloat) {
        _exp += up
        let en = expNext()
        if _exp >= en {
            _exp = _exp - en
            levelup()
        }
    }
    func levelup() {
        
    }
    func expNext() -> CGFloat {
        let level = _level + 1
        let t = atan(level * 0.1)
        var rate:CGFloat = 0.5
        if level < 6 {
            
        } else if level < 11 {
            rate = 1
        } else if level < 21 {
            rate = 1.5
        } else if level < 31 {
            rate = 2
        } else {
            rate = 3
        }
        let at = t * t * rate
        return 100 * level + level * level * level * at
    }
    
    func strengthChange(value: CGFloat) {
        _main.strength += value
        _extended.attack += value * 2
        _extended.defence += value * 0
        _extended.speed += value * 0.5
        _extended.accuracy += value * 0.2
        _extended.avoid += value * 0
        _extended.critical += value * 0.2
        _extended.spirit += value * -0.6
        _extended.hitPoint += value * 1
        _extended.hitPointMax += value * 1
        _extended.mana += value * 1
        _extended.manaMax += value * 1
        if _extended.hitPoint < 1 {
            _extended.hitPoint = 1
        }
        if _extended.mana < 1 {
            _extended.mana = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _main.agility += value
        _extended.attack += value * 0.6
        _extended.defence += value * 0.1
        _extended.speed += value * 2
        _extended.accuracy += value * 0.6
        _extended.avoid += value * 0.9
        _extended.critical += value * 0.3
        _extended.spirit += value * 0
        _extended.hitPoint += value * 2
        _extended.hitPointMax += value * 2
        _extended.mana += value * 1
        _extended.manaMax += value * 1
        if _extended.hitPoint < 1 {
            _extended.hitPoint = 1
        }
        if _extended.mana < 1 {
            _extended.mana = 1
        }
    }
    func intellectChange(value: CGFloat) {
        _main.intellect += value
        _extended.attack += value * -0.5
        _extended.defence += value * 0.2
        _extended.speed += value * 0.2
        _extended.accuracy += value * 0
        _extended.avoid += value * 0.2
        _extended.critical += value * 0
        _extended.spirit += value * 2
        _extended.hitPoint += value * 1
        _extended.hitPointMax += value * 1
        _extended.mana += value * 3
        _extended.manaMax += value * 3
        if _extended.hitPoint < 1 {
            _extended.hitPoint = 1
        }
        if _extended.mana < 1 {
            _extended.mana = 1
        }
    }
}

