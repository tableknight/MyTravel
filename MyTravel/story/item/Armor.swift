//
//  Armor.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/3.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Armor:NSObject, Codable, Showable, Stackable {
    var quality: Int {
        get {
            return _quality
        }
    }
    
    
    override init() {
        super.init()
    }
    init(_ type:String) {
        super.init()
        if type.isEmpty {
            debug("armor type is empty!")
            return
        }
        _type = type
        setValue()
    }
    
    func setValue() {
        let data = ArmorData.data[_type]!
        _type = data.type
        _name = data.name
        _description = data.desc
        let _attackSpeedMax = data.attackSpeedMax
        let _attackSpeedMin = data.attackSpeedMin
        _baseAttrs = data.baseAttrs
        if _attackSpeedMax == _attackSpeedMin && _attackSpeedMax > 0 {
            _attackSpeed = _attackSpeedMin.toFloat() * 0.01
        } else if _attackSpeedMax > _attackSpeedMin {
            _attackSpeed = seed(min: _attackSpeedMin, max: _attackSpeedMax).toFloat() * 0.01
        }
    }
    
    func create(level:Int) {
        if level > 40 {
            _level = 40
        } else if level < 1 {
            _level = 1
        } else {
            _level = level
        }
        createQuality()
//        _description = "这个是什么玩意"
        if _type == Armor.Instrument || _type == Armor.MagicMark {
            createSpell()
        } else if _type == Armor.Wand {
            _showingText = "杖"
        }
        listStatus = Armor.attributeArrays.clone() as! Array<Int>
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    
    private func createSpell() {
//        if _quality == Quality.NORMAL {
//            _spell = Loot.getRandomNormalSpellId()
//        } else if _quality == Quality.GOOD {
//            _spell = Loot.getRandomGoodSpellId()
//        } else if _quality == Quality.RARE {
//            _spell = Loot.getRandomRareSpellId()
//        } else {
//            _spell = Loot.getRandomSacredSpellId()
//        }
        _spell = Spell.LowerFlame
        let spell = Core.getSpellById(id: _spell)
        _description = "[\(spell._name)]"
    }
    private func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
    }
    
    private func createPrice() {
        let _min = _level + 1
        let _max = _level + 10
        _price = seed(min: _min, max: _max) * (_quality + 1)
        _price = _price / 2
    }
    
    private func createQuality() {
        if _type == Armor.SoulStone || _type == Armor.MagicMark {
            _attrCount = 0
            let _seed = seed()
            if _seed < 48 {
                _quality = Quality.NORMAL
            } else if _seed < 72 {
                _quality = Quality.GOOD
            } else if _seed < 94 {
                _quality = Quality.RARE
            } else {
                _quality = Quality.SACRED
            }
        } else {
            let _seed = seed()
            if _seed < 70 {
                _quality = Quality.NORMAL
                _attrCount = seed(min: 1, max: 3)
            } else if _seed < 90 {
                _quality = Quality.GOOD
                _attrCount = seed(min: 2, max: 4)
            } else {
                _quality = Quality.RARE
                _attrCount = seed(min: 3, max: 6)
            }
        }
    }
    private var _selfAttrs:Array<Int> = []
    private func createSelfAttrs() {
        for type in _baseAttrs {
            let a = Attribute(type: type, level: _level)
            let index = listStatus.firstIndex(of: type)
            if nil != index {
                listStatus.remove(at: index!)
            }
            _attrs.append(a)
        }
    }
    private func createAttr(attrId:Int, value:CGFloat = 0, remove:Bool = true, hidden:Bool = false) {
        let attr = Attribute(type: attrId, level: _level)
        if value != 0 {
            attr._value = value
        }
        if hidden {
            attr._hidden = true
        }
        _attrs.append(attr)
        if remove {
            removeAttrId(id: attrId)
        }
    }
    private func createAttrs() {
        if _attrCount < 1 {
            return
        }
        for _ in 1..._attrCount {
            let index = seed(max: listStatus.count)
            let attr = Attribute(type: listStatus[index], level: _level)
            _attrs.append(attr)
            listStatus.remove(at: index)
        }
    }
    private func removeAttrId(id:Int) {
        let index = listStatus.firstIndex(of: id)
        if nil != index {
            listStatus.remove(at: index!)
        }
    }
    func on() {
        let char = Game.curChar!
        for a in _attrs {
            a.on(unit: char)
        }

        if _type == Armor.SoulStone {
            _reserveInt = char._race
            char._race = _race
        }

        if _type == Armor.MagicMark || _type == Armor.Instrument ||  _effection == Sacred.PandoraHeart {
            if _effection == Sacred.TheMonatNotes {
                if char.hasSpell(id: _spell) {
                    char._spells.append(_spell)
                    _reserveInt = 1
                } else {
                    char._spells.append(_spell)
                    char._spells.append(_spell)
                    _reserveInt = 2
                }
            } else {
                if !(char.hasSpell(id: _spell)) {
                    char._spells.append(_spell)
                    _reserveBool = true
                }
            }
        }
        if _effection == Sacred.RingOfReborn {
            char._spellsHidden.append(_spell)
            _reserveBool = true
        } else if _effection == Sacred.Faceless {
            char._spellsHidden.append(Spell.FacelessSpell)
        }
        //
        if _effection == Sacred.TrueLie || _effection == Sacred.TheEye {
            char._spellCount += 1
        } else if _effection == Sacred.PuppetMark {
            char._spellCount -= 1
            if char._spellsInuse.count > char._spellCount {
                let spell = char._spellsInuse.popLast()!
                char._spells.append(spell)
            }
            char._minionCount += 1
        } else if _effection == Sacred.IdlirWeddingRing {
//            _reserveStr = char._imgUrl
//            let t = SKTexture(imageNamed: "idlir_bride.png")
//            char._img = t
//            Game.instance.curStage._curScene._role._charTexture = t
        } else if _effection == Sacred.RingOfDead {
            char._race = EvilType.RISEN
        } else if _effection == Sacred.PuppetMaster {
            char._minionCount += 1
        } else if _effection == Sacred.ElementalSword {
            var hasSpell = false
            let sps = char._spellsInuse + char._spellsHidden
            for s in sps {
                if s == Spell.ElementMaster {
                    hasSpell = true
                }
            }
            if !hasSpell {
                char._spellsHidden.append(Spell.ElementMaster)
                _reserveBool = true
            }
        }
//        Sound.play(node:Game.instance.curStage, fileName: "off")
    }
    func off() {
        let c = Game.curChar!
        for a in _attrs {
            a.off(unit: c)
        }

        if _type == Armor.SoulStone {
            c._race = _reserveInt
        } else if _type == Armor.MagicMark || _type == Armor.Instrument || _effection == Sacred.PandoraHeart {

            if _effection == Sacred.TheMonatNotes {
                if _reserveInt == 1 {
                    c.removeSpell(id: _spell)
                    _reserveInt = 0
                } else if _reserveInt == 2 {
                    c.removeSpell(id: _spell)
                    c.removeSpell(id: _spell)
                    _reserveInt = 0
                }
            } else {
                if _reserveBool {
                    c.removeSpell(id: _spell)
                    _reserveBool = false
                }
            }
        }
        if _effection == Sacred.RingOfReborn {
            _reserveBool = false
            let index = c._spellsHidden.firstIndex(of: _spell)
            c._spellsHidden.remove(at: index!)
        } else if _effection == Sacred.Faceless {
            _reserveBool = false
            let index = c._spellsHidden.firstIndex(of: _spell)
            c._spellsHidden.remove(at: index!)
        } else if _effection == Sacred.ElementalSword {
            if _reserveBool {
                _reserveBool = false
                let index = c._spellsHidden.firstIndex(of: Spell.ElementMaster)
                c._spellsHidden.remove(at: index!)
            }
        } else if _effection == Sacred.TrueLie || _effection == Sacred.TheEye {
            if c._spellsInuse.count >= c._spellCount {
                let last = c._spellsInuse.popLast()
                c._spells.append(last!)
            }
            c._spellCount -= 1
        } else if _effection == Sacred.PuppetMark {
//            c._minionCount -= 1
//            let minions = c.getReadyMinions()
//            if minions.count > c._minionCount {
//                minions[0]._seat = BUnit.STAND_BY
//            }
//            c._spellCount += 1
        } else if _effection == Sacred.IdlirWeddingRing {
//            let t = SKTexture(imageNamed: _reserveStr)
//            c._img = t
//            Game.instance.curStage._curScene._role._charTexture = t
        } else if _effection == Sacred.RingOfDead {
            if nil != c._soulStone {
                c._race = c._soulStone!._race
            } else {
                c._race = EvilType.MAN
            }
        } else if _effection == Sacred.PuppetMaster {
            c._minionCount -= 1
//            let minions = c.getReadyMinions()
//            if minions.count > c._minionCount {
//                minions[0]._seat = BUnit.STAND_BY
//            }
        } else if _effection == Sacred.TheMonatNotes {
//            if _reserveBool && getSpellFromMonatNotes().count > 1 {
//                c.removeSpell(id: _spell)
//                _reserveBool = false
//            }
        }
        
    }
    
    func isWeapon() -> Bool {
        let ts = [Armor.Sword, Armor.Bow, Armor.Blunt, Armor.Dagger, Armor.Instrument, Armor.Fist, Armor.Wand]
        if ts.firstIndex(of: _type) != nil {
            return true
        }
        
        return false
    }
    
    var _attrs = Array<Attribute>()
    var _name = ""
    var _unique = false
    var _effection = ""
    var _attackSpeed:CGFloat = -1
    var _baseAttrs = Array<Int>()
    var _chance = 0
    var _race = EvilType.MAN
    var _reserveStr = ""
    var _reserveBool = false
    var _reserveInt = -1
    var _showingText = ""
    var _spell = 0
    var _spellText = ""
    var _quality = 0
    var _level = 1
    var _type = ""
    var _price = 0
    var _description = ""
    var stackable: Bool = false
    internal var _attrCount:Int = 0
    private var listStatus = Array<Int>()
    
    static let attributeArrays = [Attribute.STRENGTH,
                                  Attribute.AGILITY,
                                  Attribute.INTELLECT,
                                  Attribute.DEFENCE,
                                  Attribute.SPEED,
                                  Attribute.SPIRIT,
                                  Attribute.ACCURACY,
                                  Attribute.AVOID,
                                  Attribute.CRITICAL,
                                  Attribute.HIT_POINT,
                                  Attribute.MIND,
                                  Attribute.FIREPOWER,
                                  Attribute.FIRERESISTANCE,
                                  Attribute.WATERPOWER,
                                  Attribute.WATERRESISTANCE,
                                  Attribute.THUNDERPOWER,
                                  Attribute.THUNDERRESISTANCE,
                                  Attribute.LUCKY,
                                  Attribute.BREAK,
                                  Attribute.REVENGE,
                                  Attribute.RHYTHM,
                                  Attribute.PHYSICAL_REDUCE_PERCENT,
                                  Attribute.PHYSICAL_REDUCE_POINT
    ]
    
    
    static let Wand = "Wand"
    static let Bow = "Bow"
    static let Blunt = "Blunt"
    static let Sword = "Sword"
    static let Instrument = "Instrument"
    static let Fist = "Fist"
    static let Dagger = "Dagger"
    static let MagicMark = "MagicMark"
    static let SoulStone = "SoulStone"
    static let Shield = "Shield"
    static let Ring = "Ring"
    static let Amulet = "Amulet"
    static let EarRing = "EarRing"
}

