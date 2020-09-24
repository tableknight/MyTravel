//
//  ItemWindow.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/16.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ItemWindow: Window {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create(item:Showable) {
        let item = item as! Item
        let z = self.zPosition + 200
        
        let name = Label()
        name.text = "Lv\(item._level) [\(item._name)]"
        name.fontSize = 16
        name.fontColor = QualityColor.getColor(item._quality)
        name.zPosition = z
        addChild(name)
        
        width = (name.text.count - 1).toFloat() * name.fontSize
        height = cellSize + name.fontSize
        
        let des = MultiLabel()
        des.fontSize = cellSize / 3.6
        if !item._description.isEmpty {
            des.lineCharNm = 10
            des.text = item._description
            des.fontColor = QualityColor.GOOD
            height += des.height
            des.zPosition = z
            addChild(des)
        }
        
        let price = Label()
        if item._price > 0 {
            price.fontSize = cellSize / 4
            price.text = "出售价格：\(item._price)G"
            price.fontColor = UIColor.orange
            price.zPosition = z
            height += cellSize / 2
            addChild(price)
        }
        
        name.position.x = -width * 0.5 + cellSize * 0.25
        name.position.y = (height - cellSize - name.fontSize) * 0.5
        
        var lastY = name.y - cellSize / 2
        
        if !des.text.isEmpty {
            des.x = name.x
            des.y = lastY
            lastY = des.y - des.height
        }
        
        if item._price > 0 {
            price.x = name.x
            price.y = lastY - cellSize / 2
        }
        
        _backgroundNode = createBackground(width: self.width, height: self.height)
        _backgroundNode.alpha = 1
        addChild(_backgroundNode)
    }
    
}

