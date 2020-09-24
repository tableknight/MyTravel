//
//  Field.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Field: NSObject, Codable {
    override init() {
        super.init()
    }
    
    init(type:String) {
        super.init()
        _type = type
        let size = Size.display_cell_size
        if Field.Hexagram == type {
            _fieldSeats.append(createSeat(index: 1, x: -size, y: size))
            _name = "六芒星"
        } else if Field.Sagittarius == type {
            let data = FieldData.data[_type]!
            for s in data {
                _fieldSeats.append(createSeat(index: s.index, x: s.displayX, y: s.displayY))
            }
            _name = "人马座"
        }
    }
    
    private func createSeat(index:Int, x:CGFloat, y:CGFloat) -> FieldSeat {
        let fs = FieldSeat()
        fs._index = index
        fs._x = x
        fs._y = y
        return fs
    }
    
    var _fieldSeats = Array<FieldSeat>()
    var _name = ""
    var _type = ""
    static let Hexagram = "Hexagram"
    static let Sagittarius = "Sagittarius"
}
class FieldSeat: NSObject, Codable {
    override init() {
        super.init()
    }
    var _index = 0
    var _x:CGFloat = 0
    var _y:CGFloat = 0
    var _uid = ""
}
