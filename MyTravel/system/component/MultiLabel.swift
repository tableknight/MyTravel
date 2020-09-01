//
//  MultiLabel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/1.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class MultiLabel:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var lineCharNm:Int {
        set {
            _lineCharNumber = newValue
        }
        get {
            return _lineCharNumber
        }
    }
    private var _lineCharNumber = 0
    var fontSize:CGFloat = 12
    private var _lineHeight:CGFloat = 0
    var height:CGFloat = 0
    var width:CGFloat = 0
    private var _text:String = ""
    var text:String {
        set {
            if newValue == "" {
                return
            }
            _text = newValue
            var lines = newValue.count / _lineCharNumber
            if newValue.count % _lineCharNumber == 0 {
                lines -= 1
            }
            if _lineHeight == 0 {
                _lineHeight = fontSize + 8
            }
            for i in 0...lines {
//                let y = i / _lineCharNumber
                let label = Label()
                var str = ""
                var x = 0
                for c in newValue {
                    if x >= i * _lineCharNumber && x < (i + 1) * _lineCharNumber {
                        str.append(c)
                    }
                    x += 1
                }
                label.text = str
                label.position.y -= i.toFloat() * _lineHeight
                label.fontSize = fontSize
//                label.align = "center"
                addChild(label)
            }
            
            height = lines.toFloat() * _lineHeight
            width = _lineCharNumber.toFloat() * fontSize
        }
        get {
            return _text
        }
    }
}
