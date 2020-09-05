//
//  item.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/15.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Item:NSObject, Codable, Showable {
    
    override init() {
        
    }
    init(_ type:String) {
        super.init()
        if type.isEmpty {
            return
        }
        _type = type
        setValue()
    }
    
    func setValue() {
        let data = ItemData.data[_type]!
        _type = data.type
        _name = data.name
        _showingText = data.showingText
        _description = data.desc
        _count = data.count
        _quality = data.quality
        _level = data.level
        _value = data.value
        _price = data.price
        _priceType = data.priceType
        autoCast = data.autoCast
        usable = data.usable
        castable = data.castable
        self.stackable = data.stackable

        if _type == Item.SealScroll {
            targetEnemy = true
        } else if _type == Item.MagicSyrup {
            _reserveBool = seed() < 50
            _description = "法术敏感\(_reserveBool ? "提升" : "降低")1"
        } else if _type == Item.RedoSeed {
            _reserveBool = seed() < 50
            _reserveInt = seed(min: 1, max: 3)
            let v = abs(_reserveInt)
            let b = _reserveInt < 0
            if 1 == v {
                if b {
                    _description = "力量 +1，敏捷 -1"
                } else {
                    _description = "力量 -1，敏捷 +1"
                }
            } else if 2 == v {
                if b {
                    _description = "力量 +1，智力 -1"
                } else {
                    _description = "力量 -1，智力 +1"
                }
            } else if 3 == v {
                if b {
                    _description = "敏捷 +1，智力 -1"
                } else {
                    _description = "敏捷 -1，智力 +1"
                }
            }
        }
    }
    
    var targetAll: Bool = false
    var canBeTargetSelf: Bool = false
    var targetEnemy: Bool = false
    var isClose: Bool = false
    var autoCast: Bool = false
    var canBeTargetSummonUnit: Bool = false
    var showCount = true
    var stackable = true
    var usable = false
    var castable = false
    var _type = ""
    var _name = ""
    var _showingText = ""
    var _description = ""
    var _count = 1
    var _quality = 1
    var _level = 1
    var _value:CGFloat = 0
    var _price = 0
    var _priceType = 1
    var _spell = -1
    var _reserveStr = ""
    var _reserveBool = false
    var _reserveInt = -1
    
    static let PRICE_TYPE_GOLD = 1
    static let PRICE_TYPE_TEAR = 2
    
    static let Tear = "Tear"
    static let Meat = "Meat"
    static let Skin = "Skin"
    static let GoatHoof = "GoatHoof"
    static let Milk = "Milk"
    static let LizardEye = "LizardEye"
    static let Mushroom = "Mushroom"
    static let Egg = "Egg"
    
    static let SpellBook = "SpellBook"
    static let TearEssence = "TearEssence"
    static let CreatureEssence = "CreatureEssence"
    static let TownScroll = "TownScroll"
    static let GodTownScroll = "GodTownScroll"
    static let DeathTownScroll = "DeathTownScroll"
    static let GoldPackage = "GoldPackage"
    static let RedoSeed = "RedoSeed"
    static let MagicSyrup = "MagicSyrup"
    
    static let Potion = "Potion"
    static let LittlePotion = "LittlePotion"
    static let GiantPotion = "GiantPotion"
    static let MPPotion = "MPPotion"
    static let LittleMPPotion = "LittleMPPotion"
    static let SoulMPPotion = "SoulMPPotion"
    static let SummonScroll = "SummonScroll"
    static let PsychicScroll = "PsychicScroll"
    static let ExpBook = "ExpBook"
    static let StarStone = "StarStone"
    static let SoulEssence = "SoulEssence"
    static let SealScroll = "SealScroll"
    static let TransportScroll = "TransportScroll"
    static let RandomSacredSpell = "RandomSacredSpell"
    
    static let DragonRoot = "DragonRoot"
    static let SkyAroma = "SkyAroma"
    static let PanGrass = "PanGrass"
    static let Caesalpinia = "Caesalpinia"
    static let Curium = "Curium"
    static let Angelsfuther = "Angelsfuther"
    static let DemonsBlood = "DemonsBlood"
    
    static let PureMagicStone = "PureMagicStone"
    static let MagicStone = "MagicStone"
    static let PureLifeStone = "PureLifeStone"
    static let LifeStone = "LifeStone"
    static let FireStone = "FireStone"
    static let WaterStone = "WaterStone"
    static let PureWaterStone = "PureWaterStone"
    static let PureFireStone = "PureFireStone"
    
    static let GoldCoin = "GoldCoin"
    static let RandomArmor = "RandomArmor"
    static let RandomWeapon = "RandomWeapon"
    static let RandomSpell = "RandomSpell"
    static let TearCluster = "TearCluster"
}
