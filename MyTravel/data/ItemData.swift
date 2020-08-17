//
//  ItemData.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/15.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
struct ItemData:Codable {
    var type = ""
    var name = ""
    var showingText = ""
    var desc = ""
    var priceType = 1
    var price = 0
    var level = 1
    var count = 1
    var quality = 1
    var value:CGFloat = 0
    var stackable = true
    var imgX:CGFloat = 0
    var imgY:CGFloat = 0
    var autoCast = true
    var usable = false
    var castable = false
    
    static let data = [
        Item.Tear: ItemData(type: Item.Tear, name: "天使之泪", showingText: "泪", desc: "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力", price: 6),
        Item.Skin: ItemData(type:Item.Skin, name: "皮毛", price: 6),
        Item.GoatHoof: ItemData(type:Item.GoatHoof, name: "羊蹄", price: 6),
        Item.Milk: ItemData(type:Item.Milk, name: "牛奶", price: 6),
        Item.LizardEye: ItemData(type:Item.LizardEye, name: "蜥蜴的眼球", price: 6),
        Item.Mushroom: ItemData(type:Item.Mushroom, name: "蘑菇", price: 6),
        Item.Egg: ItemData(type:Item.Egg, name: "鸟蛋", price: 6),
        Item.Angelsfuther: ItemData(type:Item.Angelsfuther, name: "天使之羽", showingText: "羽", price: 16),
        Item.DemonsBlood: ItemData(type:Item.DemonsBlood, name: "恶魔之血", showingText: "血", price: 16),
        Item.SpellBook: ItemData(type: Item.SpellBook, name: "法术书",  showingText: "书",price: 48, stackable: false, usable: true),
        Item.TearEssence: ItemData(type: Item.TearEssence, name: "眼泪精华", showingText: "精", desc: "获取若干个天使之泪", price: 32, usable: true),
        Item.CreatureEssence: ItemData(type: Item.CreatureEssence, name: "灵魂精华", desc: "灵魂凝聚而形成的结晶", price: 36, stackable: false, usable: true),
        Item.TownScroll: ItemData(type: Item.TownScroll, name: "传送卷轴·贝", desc: "传送到\(Value.village_name)", price: 8, usable: true, castable: true),
        Item.GodTownScroll: ItemData(type: Item.GodTownScroll, name: "传送卷轴·雪", desc: "传送到神域·雪之国", price: 24, quality: Quality.RARE, usable: true, castable: true),
        Item.DeathTownScroll: ItemData(type: Item.DeathTownScroll, name: "传送卷轴·冥", desc: "传送到冥界·黄昏之城", price: 12, quality: Quality.GOOD, usable: true, castable: true),
        Item.TransportScroll: ItemData(type: Item.TransportScroll, name: "穿梭卷轴", desc: "越过面前的一块区域，只能在远古之路使用", price: 8, usable: true),
        Item.RandomSacredSpell: ItemData(type: Item.RandomSacredSpell, name: "无字天书", desc: "学会一个法术", price: 18, usable: true),
        
        Item.GoldPackage: ItemData(type: Item.GoldPackage, name: "一袋金币", showingText: "币", desc: "一袋沉甸甸的金币，不知道有多少个", price: 12, usable: true),
        Item.RedoSeed: ItemData(type: Item.RedoSeed, name: "重来的种子", showingText: "种", desc: "", price: 32, quality: Quality.SACRED, stackable: false, autoCast: false, usable: true),
        Item.MagicSyrup: ItemData(type: Item.MagicSyrup, name: "魔法糖浆", showingText: "浆", desc: "", price: 24, quality: Quality.GOOD, stackable: false, autoCast: false, usable: true),
        Item.Potion: ItemData(type: Item.Potion, name: "治疗药水", showingText: "药", desc: "恢复50%最大生命值", price: 6, quality: Quality.GOOD, value: 0.5, autoCast: false, usable: true, castable: true),
        Item.LittlePotion: ItemData(type: Item.LittlePotion, name: "小型治疗药水", showingText: "药", desc: "恢复25%最大生命值", price: 3,value: 0.25, autoCast: false, usable: true, castable: true),
        Item.GiantPotion: ItemData(type: Item.GiantPotion, name: "巨人药水", showingText: "药", desc: "恢复100%最大生命值", price: 18, quality: Quality.RARE, value: 1, autoCast: false, usable: true, castable: true),
        Item.MPPotion: ItemData(type: Item.MPPotion, name: "法力药水", showingText: "法", desc: "恢复200点法力", priceType: Item.PRICE_TYPE_TEAR, price: 6, quality: Quality.GOOD, value: 200, autoCast: false, usable: true),
        Item.LittleMPPotion: ItemData(type: Item.LittleMPPotion, name: "小型法力药水", showingText: "法", desc: "恢复75点法力", priceType: Item.PRICE_TYPE_TEAR, price: 2, value: 75, autoCast: false, usable: true),
        Item.SoulMPPotion: ItemData(type: Item.SoulMPPotion, name: "灵魂法力药水", showingText: "法", desc: "恢复450点法力", priceType: Item.PRICE_TYPE_TEAR, price: 12, quality: Quality.RARE, value: 450, autoCast: false, usable: true),
        Item.SealScroll: ItemData(type: Item.SealScroll, name: "封印卷轴", desc: "将一个虚弱的灵魂封印在卷轴里", price: 12, autoCast: false, usable: false, castable: true),
        Item.ExpBook: ItemData(type: Item.ExpBook, name: "传承之书", desc: "获得经验640点", price: 28, value: 640, autoCast: false, usable: true),
        
        Item.SummonScroll: ItemData(type: Item.SummonScroll, name: "", desc: "", usable: true),
        Item.PsychicScroll: ItemData(type: Item.PsychicScroll, name: "通灵卷轴", desc: "召唤一个强大的亡灵战士为你而战", priceType: Item.PRICE_TYPE_TEAR, price: 24, quality: Quality.SACRED, castable: true),
        Item.StarStone: ItemData(type: Item.StarStone, name: "星之石", desc: "高密度能量结晶，可以拆解出大量高纯度天使之泪", price: 128, usable: true),
        
        Item.DragonRoot: ItemData(type: Item.DragonRoot, name: "龙根", desc: "", price: 6, imgX: 11, imgY: 7),
        Item.SkyAroma: ItemData(type: Item.SkyAroma, name: "天麻", desc: "", price: 6, imgX: 7, imgY: 13),
        Item.PanGrass: ItemData(type: Item.PanGrass, name: "石菊", desc: "", price: 6, imgX: 3, imgY: 12),
        Item.Caesalpinia: ItemData(type: Item.Caesalpinia, name: "苦石莲", desc: "", price: 6, imgX: 10, imgY: 6),
        Item.Curium: ItemData(type: Item.Curium, name: "黄姜", desc: "", price: 6, imgX: 11, imgY: 5),
        
        Item.PureMagicStone: ItemData(type: Item.PureMagicStone, name: "完美火焰原石", desc: "", price: 8),
        Item.MagicStone: ItemData(type: Item.MagicStone, name: "", desc: "", price: 6),
        Item.PureLifeStone: ItemData(type: Item.PureLifeStone, name: "", desc: "", price: 8),
        Item.LifeStone: ItemData(type: Item.LifeStone, name: "", desc: "", price: 6),
        Item.FireStone: ItemData(type: Item.FireStone, name: "", desc: "", price: 6),
        Item.PureFireStone: ItemData(type: Item.PureFireStone, name: "", desc: "", price: 8),
        Item.WaterStone: ItemData(type: Item.WaterStone, name: "", desc: "", price: 6),
        Item.PureWaterStone: ItemData(type: Item.PureWaterStone, name: "", desc: "", price: 8),
        Item.TearCluster: ItemData(type: Item.TearCluster, name: "眼泪精华"),
        
        Item.GoldCoin: ItemData(type: Item.GoldCoin, name: "金币", stackable: true),
        
        Item.RandomArmor: ItemData(type: Item.RandomArmor, name: "防具", price: 12),
        Item.RandomWeapon: ItemData(type: Item.RandomWeapon, name: "武器", price: 12),
        Item.RandomSpell: ItemData(type: Item.RandomSpell, name: "法术书？", showingText: "书？", priceType: Item.PRICE_TYPE_TEAR, price: 48, quality: Quality.SACRED),
        "lvScroll": ItemData(type: "lvScroll", name: "升级卷轴", showingText: "升", priceType: Item.PRICE_TYPE_TEAR, price: 12, quality: Quality.SACRED, usable: true),
        
        
        
        
    ]
}


