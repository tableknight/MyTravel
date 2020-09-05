//
//  StatusWindow.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/1.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class StatusWindow: Window {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _backgroundNode = createBackground(width: _width, height: _height)
//        _backgroundNode.fillColor = Value.transparent_color
//        addChild(_backgroundNode)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create(item:Showable) {
        let t = item as! StatusDescription
        let ml = MultiLabel()
        ml.lineCharNm = 8
        ml.text = t._description
        ml.x = -ml.width * 0.5 - 3
        ml.y = ml.height / 2
        let gap = ml.fontSize * 2
        self.width = ml.width + gap + 6
        self.height = ml.height + gap * 2
        _backgroundNode = createBackground(width: self.width, height: self.height)
        _backgroundNode.alpha = 1
        addChild(_backgroundNode)
        addChild(ml)
    }
}

class StatusDescription: Showable {
    var _description = ""
}
