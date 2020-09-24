//
//  Creature.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/17.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Creature: Unit {
    private enum CodingKeys: String, CodingKey {
        case _stars
        case _growth
        case _birth
        case _natural
        case _sensitive
        case _type
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _stars = try values.decode(Main.self, forKey: ._stars)
        _natural = try values.decode(Main.self, forKey: ._natural)
        _birth = try values.decode(Main.self, forKey: ._birth)
        _growth = try values.decode(Main.self, forKey: ._growth)
//        _sensitive = try values.decode(Int.self, forKey: ._sensitive)
        _type = try values.decode(String.self, forKey: ._type)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_stars, forKey: ._stars)
        try container.encode(_growth, forKey: ._growth)
        try container.encode(_natural, forKey: ._natural)
        try container.encode(_birth, forKey: ._birth)
//        try container.encode(_sensitive, forKey: ._sensitive)
        try container.encode(_type, forKey: ._type)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
    init(_ type:String) {
        super.init()
        _type = type
        if type.isEmpty {
            return
        }
        let md = Minions.data[type]!
        _stars.stamina = md.settingGrowth.stamina
        _stars.strength = md.settingGrowth.strength
        _stars.agility = md.settingGrowth.agility
        _stars.intellect = md.settingGrowth.intellect
        _natural.stamina = md.settingValue.stamina
        _natural.strength = md.settingValue.strength
        _natural.agility = md.settingValue.agility
        _natural.intellect = md.settingValue.intellect
        _name = md.name
        _race = md.race
        _imgUrl = md.imgUrl
//        _img = SKTexture(imageNamed: _imgUrl)
        for s in md.spells {
            _spellsInuse.append(s)
        }
        if md.spellCountMax == md.spellCountMin {
            _spellCount = md.spellCountMin
        } else if md.spellCountMin < md.spellCountMax {
            _spellCount = seed(min: md.spellCountMin, max: md.spellCountMax)
        }
        
    }
    
    var _stars:Main = Main(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _growth:Main = Main(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _birth = Main(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _natural = Main(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _sensitive = 33
    var _type = ""
    
    func beMore() -> Bool {
        let sed = seed(max: 100)
        if sed < _quality * 20 {
            return true
        }
        
        return false
    }
    func extraProperty(value: CGFloat) -> CGFloat {
        let max = (value * 12).toInt()
        let min = (value * 3).toInt()
        var float = seed(min: min, max: max).toFloat() * 0.01
        if !beMore() {
            float *= -1
        }
        return value + float
    }
    func createQuality() {
        let l = _level.toInt()
        let sed = seed(max: 100 + l / 2)
        if sed < 50 {
            _quality = Quality.NORMAL
        } else if sed < 80 {
            _quality = Quality.GOOD
        } else if sed < 96 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
        }
    }
    func createBirthValue() {
        _birth.stamina = extraProperty(value: _natural.stamina)
        _birth.strength = extraProperty(value: _natural.strength)
        _birth.agility = extraProperty(value: _natural.agility)
        _birth.intellect = extraProperty(value: _natural.intellect)
    }
    func createGrowthValue() {
        _growth.stamina = extraProperty(value: _stars.stamina)
        _growth.strength = extraProperty(value: _stars.strength)
        _growth.agility = extraProperty(value: _stars.agility)
        _growth.intellect = extraProperty(value: _stars.intellect)
    }
    func create(quality:Int) {
        _level = 1
        _quality = quality
        createBirthValue()
        createGrowthValue()
        levelTo(level: 1)
        _extended.hitPoint = _extended.hitPointMax
//        _extensions.hi = _extensions.health
        
        createSensitive()
    }
    func create(level:CGFloat) {
        _level = level
        if _level < 1 {
            _level = 1
        } else if _level > 40 {
            _level = 40
        }
        createQuality()
        createBirthValue()
        createGrowthValue()
        levelTo(level: level)
        _extended.hitPoint = _extended.hitPointMax
//        _extensions.hp = _extensions.health
        createSensitive()
//        let l = _level.toInt()
//        if !(self is SummonUnit) {
//            if _level > 20 {
//                var rate = 1
//                if _level > 30 {
//                    rate = 2
//                }
//                let s = seed()
//                if s < 34 {
//                    _elementalResistance.fire = seed(to: l * rate).toFloat()
//                    _elementalResistance.water = seed(to: l * rate / 2).toFloat()
//                } else if s < 67 {
//                    _elementalResistance.water = seed(to: l * rate).toFloat()
//                    _elementalResistance.thunder = seed(to: l * rate / 2).toFloat()
//                } else {
//                    _elementalResistance.fire = seed(to: l * rate / 2).toFloat()
//                    _elementalResistance.thunder = seed(to: l * rate).toFloat()
//                }
//            }
//            if _level > 1 && _spellCount > _spellsInuse.count && d2() {
//                let spells = [
//                    Loot.getRandomNormalSpell(),
//                    Loot.getRandomGoodSpell(),
//                    Loot.getRandomRareSpell(),
//                    Loot.getRandomSacredSpell()]
//                let spell = spells.one()
//                if !(spell is BowSkill) && !(spell is HandSkill) && !(spell is Interchange) && !(spell is SwapHealth) {
//                    _spellsInuse.append(spell._id)
//                }
//            }
//            if _level > 30 && _spellCount > _spellsInuse.count && d3() {
//                let spells = [
//                    Loot.getRandomNormalSpell(),
//                    Loot.getRandomGoodSpell(),
//                    Loot.getRandomRareSpell(),
//                    Loot.getRandomSacredSpell()]
//                let spell = spells.one()
//                if !(spell is BowSkill) && !(spell is HandSkill) && !(spell is Interchange) && !(spell is SwapHealth) {
//                    _spellsInuse.append(spell._id)
//                }
//            }
//        }
    }
    func createSensitive() {
        _extra.sensitive = seed(min: 15, max: 56).toFloat()
    }
    func levelTo(level:CGFloat) {
        staminaChange(value: (level - 1) * _growth.stamina + _birth.stamina)
        strengthChange(value: (level - 1) * _growth.strength + _birth.strength)
        agilityChange(value: (level - 1) * _growth.agility + _birth.agility)
        intellectChange(value: (level - 1) * _growth.intellect + _birth.intellect)
        _level = level
        for _ in 1...level.toInt() {
            let sd = seed()
            if sd < 33 {
                strengthChange(value: 1)
            } else if sd < 67 {
                agilityChange(value: 1)
            } else {
                intellectChange(value: 1)
            }
        }
    }
    
    override func levelup() {
        if _level >= 40 {
            return
        }
        staminaChange(value: _growth.stamina)
        strengthChange(value: _growth.strength)
        agilityChange(value: _growth.agility)
        intellectChange(value: _growth.intellect)
        _level += 1
        _leftPoint += 1
        _extended.hitPoint = _extended.hitPointMax
//        _extensions.hp = _extensions.health
    }
    
    
    func d(baseRate:Int = 45) -> Bool {
        return seed() < baseRate + _level.toInt()
    }
    static func getCreatureByClass(c:Creature) -> Creature? {
//        if c.classForCoder == VirulentToad.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == TreeSpirit.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == Python.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == GiantWasp.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == DarkNinja.classForCoder() {
//            return DarkNinja()
//        }
        return nil
    }
    static let GreenSpirit = "GreenSpirit"
    static let Luki = "Luki"
    static let TreeSpirit = "TreeSpirit"
    static let Fairy = "Fairy"

    static let BoneWitch = "BoneWitch"
    static let RedEyeDemon = "RedEyeDemon"
    static let DeadSpirit = "DeadSpirit"
    static let WasteWalker = "WasteWalker"

    static let SnowLady = "SnowLady"
    static let FrozenSlime = "FrozenSlime"
    static let IceBeast = "IceBeast"
    static let SnowSpirit = "SnowSpirit"

    static let BloodBat = "BloodBat"
    static let Kodagu = "Kodagu"
    static let EvilSpirit = "EvilSpirit"
    static let HellBaron = "HellBaron"

    static let ChildLizard = "ChildLizard"
    static let ForestGuard = "ForestGuard"
    static let CrazyPlant = "CrazyPlant"
    static let CrazyCow = "CrazyCow"

    static let DarkNinja = "DarkNinja"
    static let HellNight = "HellNight"
    static let BloodQueen = "BloodQueen"
    static let ManWizard = "ManWizard"

}
