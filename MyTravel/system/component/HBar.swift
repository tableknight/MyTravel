//
//  HBar.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/23.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class HBar:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        self.zPosition = UIStage.UILAYER
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _bar:SKShapeNode!
    private var _color:UIColor!
    private var _radius:CGFloat = 3
    func setValue(value:CGFloat = 1) {
        _bar?.removeFromParent()
        var v = value
        if value > 1 {
            v = 1
        }
        let width = _width * v
        _bar = createBackground(width: width, height: _height, cornerRadius: _radius)
        _bar.fillColor = _color
        _bar.position.x = width * 0.5
        addChild(_bar)
    }
    var _width:CGFloat = 0
    var _height:CGFloat = 6
    func create(width:CGFloat, height:CGFloat, value:CGFloat, color:UIColor, cornerRadius:CGFloat = 3) {
        _width = width
        _height = height
        _color = color
        _radius = cornerRadius
        let bg = createBackground(width: width, height: height, cornerRadius: cornerRadius)
        //        let bg = SKShapeNode(rect: CGRect(x: 0, y: -_height * 0.5, width: width, height: height))
        bg.fillColor = UIColor.black
        bg.lineWidth = 1
        bg.strokeColor = UIColor.white
        bg.position.x = width * 0.5
        addChild(bg)
        setValue(value: value)
    }
}

