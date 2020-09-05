//
//  FieldSlot.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class FieldSlot: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        selected = true
        _imageStar = SKTexture(imageNamed: "stars").getNode(1, 0)
//        star.x = cellSize * 0.5
        addChild(_imageStar)
        _starName.fontSize = cellSize / 3.6
        _starName.y = cellSize * 0.25
        _starName.x = cellSize * 0.5
        _starName.verticalAlign = "center"
        addChild(_starName)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var starName:String {
        set {
            _starName.text = newValue
        }
        get {
            return ""
        }
    }
    var image:String {
        set {
            if "star" == newValue {
                _imageStar.isHidden = false
                _imageUnit.removeFromParent()
            } else {
                _imageStar.isHidden = true
                _imageUnit = SKTexture(imageNamed: newValue).getNode(1, 0)
                _imageUnit.size = CGSize(width: cellSize * 0.75, height: cellSize * 0.75)
                addChild(_imageUnit)
            }
        }
        get {
            return ""
        }
    }
//    override var selected:Bool {
//        set {
//            _selected = newValue
//            if newValue {
//                _backgroundNode.lineWidth = 3
//            } else {
//                _backgroundNode.lineWidth = 2
//            }
//        }
//        get {
//            return _selected
//        }
//    }
    private var _starName = Label()
    private var _imageStar:SKSpriteNode!
    private var _imageUnit:SKSpriteNode!
    var _fieldSeat:FieldSeat!
}
