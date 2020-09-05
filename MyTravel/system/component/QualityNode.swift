//
//  QualityNode.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class QualityNode: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _backgroundNode.lineWidth = Value.selected_stroke_width
            } else {
                _backgroundNode.lineWidth = Value.unselected_stroke_width
            }
        }
        get {
            return _selected
        }
    }
    
    var quality:Int {
        set {
            if newValue == Quality.SACRED {
                _backgroundNode.strokeColor = QualityColor.SACRED
            } else if newValue == Quality.GOOD {
                _backgroundNode.strokeColor = QualityColor.GOOD
            } else if newValue == Quality.RARE {
                _backgroundNode.strokeColor = QualityColor.RARE
            } else {
                _backgroundNode.strokeColor = QualityColor.NORMAL
            }
            
        }
        get {
            return 0
        }
    }
    internal var _backgroundNode:SKShapeNode!
}
