//
//  RoleThumb.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/28.
//  Copyright © 2020 my.travel. All rights reserved.
//


import SpriteKit
class RoleThumb: QualityNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _height = (Size.default_cell_y_count + 2).toFloat() * cellSize
        _width = cellSize * 1.5
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(unit:Unit?) {
        _backgroundNode = createBackground(width: _width, height: _height, cornerRadius: 6)
        _backgroundNode.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.875)
        addChild(_backgroundNode)
        if nil == unit {
            return
        }
        let unit = unit!
        _unit = unit
        let gap = cellSize / 4
//        let startX = -_width * 0.5 + gap
        let startY = _height * 0.5 - cellSize * 0.875
        
        let img = SKTexture(imageNamed: unit._imgUrl).getNode(1, 0)
//        img.size = CGSize(width: _height * 0.75, height: _height * 0.75)
//        img.x = startX + img.size.width * 0.5
        img.y = startY
        addChild(img)
        
        let lv = Label()
        lv.verticalAlign = "baseline"
        lv.text = "LEVEL \(unit._level.toInt())"
        lv.fontSize = 9
        lv.align = "center"
        lv.y = startY - cellSize * 1.25
        addChild(lv)
        
//        let name = Label()
//        name.verticalAlign = "baseline"
//        name.text = unit._name
//        name.fontSize = 12
//        name.align = "center"
//        name.y = lv.y - cellSize / 2
////        name.x = startX + img.size.width + gap
//        addChild(name)
        
        let barX = -cellSize / 2
        
        let barWidth = cellSize
        let barHeight = cellSize / 5
        _hpbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.hp, cornerRadius: 2)
        _hpbar.x = barX
        _hpbar.y = lv.y - gap
        addChild(_hpbar)
        
        _mpbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.mp, cornerRadius: 2)
        _mpbar.x = barX
        _mpbar.y = _hpbar.y - barHeight * 1.9
        addChild(_mpbar)
        
        _expbar.create(width: barWidth, height: barHeight, value: 1, color: BarColor.exp, cornerRadius: 2)
        _expbar.x = barX
        _expbar.y = _mpbar.y - barHeight * 1.9
        addChild(_expbar)
        
        let iconY = _expbar.y - cellSize * 0.875
        
        for i in 0...2 {
            let icon = Icon()
//            icon.iconText
            icon.y = iconY - (cellSize * 1.125 * i.toFloat())
            addChild(icon)
        }
        
        
    }
    
    var width:CGFloat {
        set {
            _width = newValue
        }
        get {
            return _width
        }
    }
    
    var _unit:Unit!
    internal var _width:CGFloat = 0
    internal var _height:CGFloat = 0
    private var _hpbar = HBar()
    private var _mpbar = HBar()
    private var _expbar = HBar()
}

