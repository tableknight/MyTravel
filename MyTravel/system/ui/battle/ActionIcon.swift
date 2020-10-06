//
//  ActionIcon.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/9.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ActionIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name.fontSize = cellSize / 3.6
        _name.y = -cellSize * 0.75
        _name.align = "center"
//        _name.x = -1
        _label.fontColor = UIColor.black
        addChild(_name)
        let node = createBackground(width: cellSize * 0.75, height: cellSize * 0.75, cornerRadius: 6)
        node.lineWidth = 0
        node.fillColor = UIColor.white
        addChild(node)
        _innerBGNode = node
//        self.alpha = 0.75
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createBackgroundNode() {
        _height = cellSize
        _width = cellSize
        _backgroundNode = createBackground(width: _width, height: _height * 1.5, cornerRadius: 6)
        _backgroundNode.y = -cellSize * 0.25
        _backgroundNode.fillColor = Value.transparent_color
        _backgroundNode.lineWidth = 0
//        _backgroundNode.alpha = 0.75
        addChild(_backgroundNode)
    }
    var actionName:String {
        set {
            _name.text = newValue
            if newValue.count > 2 {
                _name.fontSize = 8
            }
        }
        get {
            return ""
        }
    }
    var image:SKSpriteNode {
        set {
            if nil != _imageUnit {
                _imageUnit.removeFromParent()
            }
//            _imageUnit
            _imageUnit = newValue
            _imageUnit.size = CGSize(width: cellSize * 0.75, height: cellSize * 0.75)
            addChild(_imageUnit)
        }
        get {
            return SKSpriteNode()
        }
    }
    override var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _innerBGNode.fillColor = QualityColor.GOOD
//                self.alpha = 1
//                _backgroundNode.lineWidth = 1
            } else {
                _innerBGNode.fillColor = UIColor.white
//                self.alpha = 0.75
//                _backgroundNode.lineWidth = 0
            }
        }
        get {
            return _selected
        }
    }
    override var iconText:String {
        set {
            _label.zPosition = self.zPosition + 100
            if newValue.count > 1 {
                for c in newValue {
                    _label.text = String(c)
                    break
                }
            } else {
                _label.text = newValue
            }
        }
        get {
            return ""
        }
    }
    private var _name = Label()
    private var _imageUnit:SKSpriteNode!
    var _spell:Spell!
    private var _innerBGNode = SKShapeNode()
    var notForAuto = false
}

