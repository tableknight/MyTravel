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
    func addItem(_ item: Item, count:Int = 1) {
        if item.stackable {
            var exist = false
            for i in _items {
                if i._type == item._type {
                    //                    i._count += item._count
                    i._count += count
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
    func removeItem(_ item:Item, _ count:Int = 1) {
        for idx in 0..._items.count - 1 {
            let i = _items[idx]
            if i._type == item._type {
                i._count -= count
                if i._count < 1 {
                    _items.remove(at: idx)
                }
                break
            }
        }
    }
    var _fields = Array<Field>()
    var _selectedField:Field!
    var _items = Array<Item>()
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
}
