//
//  Thumb.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Thumb: QualityNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _height = cellSize * 1.5
        _width = cellSize * 4
        _backgroundNode = createBackground(width: _width, height: _height)
        _backgroundNode.fillColor = Value.transparent_color
        addChild(_backgroundNode)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(unit:Unit) {
        _unit = unit
        let gap = _height * 0.125
        let startX = -_width * 0.5 + gap
        let startY = _height * 0.5 - gap
        let img = SKTexture(imageNamed: unit._imgUrl).getNode(1, 0)
        img.size = CGSize(width: _height * 0.75, height: _height * 0.75)
        img.x = startX + img.size.width * 0.5
        img.y = startY - img.size.height * 0.5
        addChild(img)
        
        let name = Label()
        name.verticalAlign = "baseline"
        name.text = "Lv\(unit._level.toInt())[\(unit._name)]"
        name.fontSize = 12
        name.y = startY - name.fontSize
        name.x = startX + img.size.width + gap
        addChild(name)
        
        let barWidth = _width * 0.55
        let barHeight = _height * 0.085
        _hpbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.hp, cornerRadius: 2)
        _hpbar.x = name.x
        _hpbar.y = name.y - gap
        addChild(_hpbar)
        
        _mpbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.mp, cornerRadius: 2)
        _mpbar.x = name.x
        _mpbar.y = _hpbar.y - barHeight * 1.9
        addChild(_mpbar)
        
        _expbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.exp, cornerRadius: 2)
        _expbar.x = name.x
        _expbar.y = _mpbar.y - barHeight * 1.9
        addChild(_expbar)
        
        
    }
    
    internal var _unit:Unit!
    internal var _width:CGFloat = 0
    internal var _height:CGFloat = 0
    private var _hpbar = HBar()
    private var _mpbar = HBar()
    private var _expbar = HBar()
}
