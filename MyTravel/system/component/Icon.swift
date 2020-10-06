//
//  Icon.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Icon: QualityNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        createBackgroundNode()
        
        _label.fontSize = cellSize * 0.5
        _label.align = "center"
        _label.verticalAlign = "center"
        addChild(_label)
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal func createBackgroundNode() {
        _height = cellSize
        _width = cellSize
        _backgroundNode = createBackground(width: _width, height: _height)
        _backgroundNode.fillColor = Value.transparent_color
        addChild(_backgroundNode)
    }
    
    var iconText:String {
        set {
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
    
    var count:Int {
        set {
            _count = newValue
            if _count > 1 || mustShowCount {
                if contains(_countLabel) {
                    _countLabel.text = "\(_count)"
                } else {
                    _countLabel.fontSize = cellSize * 0.25
                    _countLabel.x = -cellSize * 0.5 + 2
                    _countLabel.y = _countLabel.x
                    _countLabel.text = "\(_count)"
                    addChild(_countLabel)
                }
            }
        }
        get {
            return _count
        }
    }
    
    var countText:String {
        set {
            if contains(_countLabel) {
                _countLabel.text = newValue
            } else {
                _countLabel.fontSize = cellSize * 0.25
                _countLabel.x = -cellSize * 0.5 + 2
                _countLabel.y = _countLabel.x
                _countLabel.text = newValue
                addChild(_countLabel)
            }
        }
        get {
            return ""
        }
    }
    
    func showWIndow(pos:String = "right") {
        if _content == nil {
            return
        }
        let w:Window!
        if _content is StatusDescription {
            w = StatusWindow()
            w.create(item: _content)
        } else if _content is Armor {
            w = ArmorWindow()
            w.create(item: _content)
        } else if _content is Item {
            w = ItemWindow()
            w.create(item: _content)
        } else {
            w = Window()
        }
        if "right" == pos {
            w.x = (self._width + w.width) * 0.5 + 2
            w.y = (self._height - w.height) * 0.5
        } else if "left" == pos {
            w.x = (-w.width - self._width) * 0.5 - 2
            w.y = (self._height - w.height) * 0.5
        } else if "leftTop" == pos {
            w.x = (-w.width - self._width) * 0.5 - 2
            w.y = (-self._height + w.height) * 0.5 + 2
        } else if "rightTop" == pos {
            w.y = (-self._height + w.height) * 0.5 + 2
            w.x = (self._width + w.width) * 0.5 + 2
        }
        addChild(w)
        _window = w
    }
    
    override var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _backgroundNode.fillColor = UIColor.white
                _label.fontColor = UIColor.black
            } else {
                _backgroundNode.fillColor = UIColor.black
                _label.fontColor = UIColor.white
            }
        }
        get {
            return _selected
        }
    }
    
    func removeWindow() {
        if nil != _window {
            _window.removeFromParent()
        }
    }
    
    var content:Showable {
        set {
            _content = newValue
            quality = newValue.quality
        }
        get {
            return _content
        }
    }
    
    var mustShowCount = false
    var _width:CGFloat = 0
    var _height:CGFloat = 0
    internal var _label = Label()
    var _content:Showable!
    private var _count = 0
    private var _countLabel = Label()
    private var _window:Window!
}
