//
//  UnitIcon.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/8.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class UnitIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createBackgroundNode() {
        _height = cellSize * 0.75
        _width = cellSize * 0.75
        _backgroundNode = createBackground(width: _width, height: _height, cornerRadius: 6)
        _backgroundNode.fillColor = UIColor.white
        addChild(_backgroundNode)
    }
    var image:String {
        set {
            if nil != _imageUnit {
                _imageUnit.removeFromParent()
            }
            _imageUnit = SKTexture(imageNamed: newValue).getNode(1, 0)
            _imageUnit.size = CGSize(width: _width * 0.65, height: _height * 0.65)
            addChild(_imageUnit)
        }
        get {
            return ""
        }
    }
    override var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _backgroundNode.fillColor = QualityColor.GOOD
//                _backgroundNode.lineWidth = Value.unselected_stroke_width
//                _backgroundNode.strokeColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.9)
            } else {
                _backgroundNode.fillColor = UIColor.white
//                _backgroundNode.lineWidth = Value.unselected_stroke_width
//                _backgroundNode.strokeColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
            }
        }
        get {
            return _selected
        }
    }
    private var _imageUnit:SKSpriteNode!
    var _unit:Unit!
}

