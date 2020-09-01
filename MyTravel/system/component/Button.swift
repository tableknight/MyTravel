//
//  Button.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/27.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Button:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _width = cellSize * 1.5
        _backgroundNode = createBackground(width: _width, height: cellSize * 0.6)
//        selected = true
        addChild(_backgroundNode)
        _label.position.y = -cellSize * 0.125
        _label.fontSize = 12
        _label.align = "center"
        addChild(_label)
    }
    private var _node = SKSpriteNode()
    private var _backgroundNode:SKShapeNode!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _label = Label()
    var text:String {
        set {
            _label.text = newValue
        }
        get {
            return ""
        }
    }
    private var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _backgroundNode.strokeColor = Value.selected_stroke_color
                _backgroundNode.lineWidth = Value.selected_stroke_width
            } else {
                _backgroundNode.strokeColor = Value.unselected_stroke_color
                _backgroundNode.lineWidth = Value.unselected_stroke_width
            }
        }
        get {
            return _selected
        }
    }
    
    var width:CGFloat {
        set {
            _backgroundNode.removeFromParent()
            _backgroundNode = createBackground(width: newValue, height: cellSize * 0.75)
            addChild(_backgroundNode)
            _width = newValue
        }
        get {
            return _width
        }
    }
    
    private var _width:CGFloat = 0

}
