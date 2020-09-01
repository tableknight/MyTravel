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
    func create(description:String) {
        let ml = MultiLabel()
        ml.lineCharNm = 8
        ml.text = "繁华不过是红尘背后的一种喧嚣，打败魔王后的生活果然是平淡而又真实。"
        ml.x = -ml.width * 0.5
        ml.y = (ml.height - ml.fontSize) / 2
        let gap = ml.fontSize * 2
        _backgroundNode = createBackground(width: ml.width + gap, height: ml.height + gap * 2)
        addChild(_backgroundNode)
        addChild(ml)
    }
}
