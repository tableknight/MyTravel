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
        for _ in 0...6 {
            let m = Creature(Creature.BloodBat)
            m.create(level: 1)
            _minions.append(m)
        }
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
    var _fields = Array<Field>()
    var _selectedField = Field(type: Field.Sagittarius)
    var _items = Array<Item>()
    var _armors = Array<Armor>()
    var _minions = Array<Creature>()
    var _minionCount = 3
}
