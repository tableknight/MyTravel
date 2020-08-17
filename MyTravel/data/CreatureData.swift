//
//  CreatureData.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/17.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit

struct Minions {
    var type = ""
    var name = ""
    var race = 1
    var settingGrowth = Main(strength: 0, agility: 0, intellect: 0 )
    var settingValue = Main(strength: 0, agility: 0, intellect: 0 )
    var imgUrl = ""
    var spellCountMin = 1
    var spellCountMax = 3
    var spells = Array<Int>()
    var lootItems = Array<String>()
    static let data = [
        Creature.GreenSpirit: Minions(
            type: Creature.GreenSpirit,
            name: "绿精灵",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.0, agility: 0.6, intellect: 1.0),
            settingValue: Main(strength: 18, agility: 12, intellect: 10),
            imgUrl: "green_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.AttackHard],
            lootItems: []
        ),
        Creature.Luki: Minions(
            type: Creature.Luki,
            name: "露琪",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 2.2, agility: 2.0, intellect: 0.8),
            settingValue: Main( strength: 22, agility: 22, intellect: 15),
            imgUrl: "luki",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.Reborn],
            lootItems: []
        ),
        Creature.TreeSpirit: Minions(
            type: Creature.TreeSpirit,
            name: "树妖",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.0, agility: 1.0, intellect: 2.2),
            settingValue: Main(strength: 10, agility: 12, intellect: 29),
            imgUrl: "tree_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.FragileCurse],
            lootItems: []
        ),
        Creature.Fairy: Minions(
            type: Creature.Fairy,
            name: "花仙子",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.5, agility: 1.3, intellect: 1.2),
            settingValue: Main(strength: 28, agility: 12, intellect: 16),
            imgUrl: "flower_fairy",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.AttackPowerUp],
            lootItems: []
        ),
        Creature.BoneWitch: Minions(
            type: Creature.BoneWitch,
            name: "白骨巫师",
            race: EvilType.RISEN,
            settingGrowth: Main(strength: 1.0, agility: 1.0, intellect: 2.8),
            settingValue: Main(strength: 10, agility: 15, intellect: 24),
            imgUrl: "bone_wizard",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.FireBreath],
            lootItems: []
        ),
        Creature.RedEyeDemon: Minions(
            type: Creature.RedEyeDemon,
            name: "红眼恶魔",
            race: EvilType.DEMON,
            settingGrowth: Main(strength: 1.0, agility: 2.1, intellect: 0.6),
            settingValue: Main(strength: 21, agility: 14, intellect: 12),
            imgUrl: "red_eye_demon",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.ChaosAttack],
            lootItems: []
        ),
        Creature.DeadSpirit: Minions(
            type: Creature.DeadSpirit,
            name: "死灵",
            race: EvilType.RISEN,
            settingGrowth: Main(strength: 0.8, agility: 2.2, intellect: 2.4),
            settingValue: Main(strength: 12, agility: 16, intellect: 16),
            imgUrl: "dead_spirit",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.DeathStrike],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "荒地行者",
            race: EvilType.RISEN,
            settingGrowth: Main(strength: 2.1, agility: 1, intellect: 0.4),
            settingValue: Main(strength: 25, agility: 19, intellect: 19),
            imgUrl: "waste_walker",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.Cruel],
            lootItems: []
        ),
        Creature.SnowLady: Minions(
            type: Creature.SnowLady,
            name: "冰雪女妖",
            race: EvilType.MAN,
            settingGrowth: Main(strength: 1.6, agility: 2.4, intellect: 0.5),
            settingValue: Main(strength: 18, agility: 22, intellect: 11),
            imgUrl: "snow_lady",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.Disappear],
            lootItems: []
        ),
        Creature.FrozenSlime: Minions(
            type: Creature.FrozenSlime,
            name: "冰冻史莱姆",
            race: EvilType.DEMON,
            settingGrowth: Main(strength: 1.1, agility: 1.5, intellect: 0.6),
            settingValue: Main(strength: 20, agility: 7, intellect: 10),
            imgUrl: "slime",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.Sacrifice],
            lootItems: []
        ),
        Creature.IceBeast: Minions(
            type: Creature.IceBeast,
            name: "寒冰巨兽",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.5, agility: 1.5, intellect: 1.5),
            settingValue: Main(strength: 12, agility: 24, intellect: 12),
            imgUrl: "ice_beast",
            spellCountMin: 1,
            spellCountMax: 1,
            spells: [Spell.QuickHeal],
            lootItems: []
        ),
        Creature.SnowSpirit: Minions(
            type: Creature.SnowSpirit,
            name: "雪精",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.1, agility: 2.5, intellect: 1.9),
            settingValue: Main(strength: 15, agility: 12, intellect: 18),
            imgUrl: "snow_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [],
            lootItems: []
        ),
        Creature.BloodBat: Minions(
            type: Creature.BloodBat,
            name: "血色蝙蝠",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.1, agility: 1.9, intellect: 0.9),
            settingValue: Main(strength: 13, agility: 18, intellect: 16),
            imgUrl: "blood_bat",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.VampireBlood],
            lootItems: []
        ),
        Creature.Kodagu: Minions(
            type: Creature.Kodagu,
            name: "达古",
            race: EvilType.DEMON,
            settingGrowth: Main(strength: 2.2, agility: 0.6, intellect: 0.6),
            settingValue: Main(strength: 22, agility: 10, intellect: 10),
            imgUrl: "Kodagu",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.VampireBlood],
            lootItems: []
        ),
        Creature.EvilSpirit: Minions(
            type: Creature.EvilSpirit,
            name: "邪灵",
            race: EvilType.RISEN,
            settingGrowth: Main(strength: 0.5, agility: 0.8, intellect: 2.9),
            settingValue: Main(strength: 18, agility: 11, intellect: 29),
            imgUrl: "evil_spirit",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.FireOrFired],
            lootItems: []
        ),
        Creature.HellBaron: Minions(
            type: Creature.HellBaron,
            name: "地狱男爵",
            race: EvilType.RISEN,
            settingGrowth: Main(strength: 0.6, agility: 2.1, intellect: 2.4),
            settingValue: Main(strength: 21, agility: 11, intellect: 11),
            imgUrl: "hell_baron",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.LifeDraw],
            lootItems: []
        ),
        Creature.ChildLizard: Minions(
            type: Creature.ChildLizard,
            name: "小蜥蜴",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 2.2, agility: 1.1, intellect: 0.6),
            settingValue: Main(strength: 12, agility: 18, intellect: 18),
            imgUrl: "child_lizard",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.IceGuard],
            lootItems: []
        ),
        Creature.ForestGuard: Minions(
            type: Creature.ForestGuard,
            name: "丛林守卫",
            race: EvilType.MAN,
            settingGrowth: Main(strength: 1.1, agility: 1.1, intellect: 2.6),
            settingValue: Main(strength: 14, agility: 22, intellect: 19),
            imgUrl: "forest_guard",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.WindPunish],
            lootItems: []
        ),
        Creature.CrazyPlant: Minions(
            type: Creature.CrazyPlant,
            name: "疯狂的草",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.6, agility: 1.4, intellect: 0.6),
            settingValue: Main(strength: 12, agility: 12, intellect: 18),
            imgUrl: "crazy_plant",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.LeeAttack],
            lootItems: []
        ),
        Creature.CrazyCow: Minions(
            type: Creature.CrazyCow,
            name: "暴躁的奶牛",
            race: EvilType.NATURE,
            settingGrowth: Main(strength: 1.0, agility: 0.6, intellect: 0.6),
            settingValue: Main(strength: 18, agility: 16, intellect: 16),
            imgUrl: "cow_cow",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.Taunt],
            lootItems: []
        ),
        Creature.DarkNinja: Minions(
            type: Creature.DarkNinja,
            name: "黑暗忍着",
            race: EvilType.MAN,
            settingGrowth: Main(strength: 2.0, agility: 2.0, intellect: 0.6),
            settingValue: Main(strength: 16, agility: 21, intellect: 14),
            imgUrl: "dark_ninja",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.Disappear],
            lootItems: []
        ),
        Creature.HellNight: Minions(
            type: Creature.HellNight,
            name: "地狱骑士",
            race: EvilType.DEMON,
            settingGrowth: Main(strength: 1.3, agility: 0.5, intellect: 0.66),
            settingValue: Main(strength: 18, agility: 13, intellect: 17),
            imgUrl: "hell_rider",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.BargeAbout],
            lootItems: []
        ),
        Creature.BloodQueen: Minions(
            type: Creature.BloodQueen,
            name: "鲜血女王",
            race: EvilType.DEMON,
            settingGrowth: Main(strength: 0.4, agility: 1.2, intellect: 2.6),
            settingValue: Main(strength: 21, agility: 18, intellect: 21),
            imgUrl: "blood_queen",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.DeathGaze],
            lootItems: []
        ),
        Creature.ManWizard: Minions(
            type: Creature.ManWizard,
            name: "旅法师",
            race: EvilType.MAN,
            settingGrowth: Main(strength: 1.1, agility: 2.5, intellect: 1.9),
            settingValue: Main(strength: 16, agility: 19, intellect: 22),
            imgUrl: "wander_wizard",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.IceSpear],
            lootItems: []
        )
        /*
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Main(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        */
    ]
}


