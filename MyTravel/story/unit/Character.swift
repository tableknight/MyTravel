//
//  Charactor.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Character: Unit {
    override init() {
        super.init()
        _imgUrl = "test_role"
        let field = Field(type: Field.Sagittarius)
        _fields.append(field)
        _selectedField = field
        let kiki = BlackCat()
        kiki.create(level: 1)
        _minions.append(kiki)
        let afu = AFu()
        afu.create(level: 1)
        _minions.append(afu)
        field._fieldSeats[0]._uid = afu._uid
        field._fieldSeats[1]._uid = kiki._uid
        field._fieldSeats[2]._uid = _uid
        _leftPoint = 10
        strengthChange(value: 10)
        staminaChange(value: 10)
        agilityChange(value: 10)
        intellectChange(value: 10)
        
        let m = Creature(Creature.ForestGuard)
        m.create(level: 1)
        _minions.append(m)
        
        let libra = Field(type: Field.Libra)
        _fields.append(libra)
        
    }
    private enum CodingKeys: String, CodingKey {
        case _birth
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        _type = try values.decode(String.self, forKey: ._type)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //        try container.encode(_stars, forKey: ._stars)
        try super.encode(to: encoder)
    }
    func getUnitById(id:String) -> Unit? {
        for m in _minions {
            if m._uid == id {
                return m
            }
        }
        if id == self._uid {
            return self
        }
        return nil
    }
    func addItem(_ item: Stackable, count:Int = 1) {
        if item.stackable {
            let newItem = item as! Item
            var exist = false
            for i in _items {
                if i is Armor {
                    continue
                }
                let listItem = i as! Item
                if listItem._type == newItem._type {
                    //                    i._count += item._count
                    listItem._count += count
                    exist = true
                    break
                }
            }
            if !exist {
                _items.insert(item, at: 0)
            }
        } else {
            _items.insert(item, at: 0)
        }
    }
    func removeItem(_ searchItem:Stackable, _ count:Int = 1) {
        for idx in 0..._items.count - 1 {
            if searchItem is Item {
                if _items[idx] is Item {
                    let targetItem = searchItem as! Item
                    let i = _items[idx] as! Item
                    if i._type == targetItem._type {
                        i._count -= count
                        if i._count < 1 {
                            _items.remove(at: idx)
                        }
                        break
                    }
                }
            } else {
                if _items[idx] is Armor {
                    let targetArmor = searchItem as! Armor
                    let i = _items[idx] as! Armor
                    if targetArmor == i {
                        _items.remove(at: idx)
                        break
                    }
                }
            }
        }
    }
    func removeSpell(id:Int) {
        var index = _spellsInuse.firstIndex(of: id)
        if nil != index {
            _spellsInuse.remove(at: index!)
            return
        }
        index = _spells.firstIndex(of: id)
        if nil != index {
            _spells.remove(at: index!)
            return
        }
        for m in _minions {
            index = m._spellsInuse.firstIndex(of: id)
            if nil != index {
                m._spellsInuse.remove(at: index!)
                return
            }
        }
    }
    func hasSpell(id:Int) -> Bool {
        var spells = _spells + _spellsInuse
        for m in _minions {
            spells += m._spellsInuse
        }
        for s in spells {
            if s == id {
                return true
            }
        }
        
        return false
    }
    var _fields = Array<Field>()
    var _selectedField:Field!
    var _items = Array<Stackable>()
    var _armors = Array<Armor>()
    var _minions = Array<Creature>()
    var _minionCount = 3
    var _weapon:Armor!
    var _amulet:Armor!
    var _leftRing:Armor!
    var _rightRing:Armor!
    var _shield:Armor!
    var _magicMark:Armor!
    var _soulStone:Armor!
    
    var autoAction = false
}
