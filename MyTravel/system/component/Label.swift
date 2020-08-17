//
//  Label.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/17.
//  Copyright © 2020 my.travel. All rights reserved.
//


import SpriteKit
class Label: SKSpriteNode {
    var align:String {
        set {
            if newValue == "left" {
                _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            } else if newValue == "right" {
                _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            } else {
                _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            }
        }
        get {
            return ""
        }
    }
    var fontSize: CGFloat {
        set {
            _label.fontSize = newValue
        }
        get {
            return 1
        }
    }
    var text: String {
        set {
            _label.text = newValue
        }
        get {
            return ""
        }
    }
    
    private var _label:SKLabelNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        for s in UIFont.familyNames {
            print(s)
        }
        print(UIFont.familyNames.count)
        _label = SKLabelNode(fontNamed: "FZFW ZhuZi A YuanS")
        _label.fontColor = UIColor.white
        _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        _label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        addChild(_label)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
//class MultipleLabel:SKSpriteNode {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    var _lineCharNumber = 0
//    var _fontSize:CGFloat = 14
//    var _lineHeight:CGFloat = 0
//    var _height:CGFloat = 0
//    private var _text:String = ""
//    var text:String {
//        set {
//            if newValue == "" {
//                return
//            }
//            _text = newValue
//            var lines = newValue.count / _lineCharNumber
//            if newValue.count % _lineCharNumber == 0 {
//                lines -= 1
//            }
//            if _lineHeight == 0 {
//                _lineHeight = _fontSize + 8
//            }
//            for i in 0...lines {
////                let y = i / _lineCharNumber
//                let label = Label()
//                var str = ""
//                var x = 0
//                for c in newValue {
//                    if x >= i * _lineCharNumber && x < (i + 1) * _lineCharNumber {
//                        str.append(c)
//                    }
//                    x += 1
//                }
//                label.text = str
//                label.position.y -= i.toFloat() * _lineHeight
//                label.fontSize = _fontSize
//                addChild(label)
//            }
//
//            _height = lines.toFloat() * _lineHeight
//        }
//        get {
//            return _text
//        }
//    }
//}
//
