//
//  ItemSelectPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/14.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ItemSelectPanel: PureItemPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            self.removeFromParent()
            closeAction()
            return
        }
        if _confirmButton.contains(touchPoint!) {
            if nil == _selectedItem {
                return
            }
            self.removeFromParent()
            confirmAction()
            return
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        _confirmButton.x = _closeButton.x - _closeButton.width - _buttonGap
        _confirmButton.y = _closeButton.y
        _confirmButton.text = "选择"
        addChild(_confirmButton)
        _discardButton.removeFromParent()
        _equipButton.removeFromParent()
    }
    override func getItems() -> Array<Item> {
        var items = Array<Item>()
        for i in Game.curChar!._items {
            if i is Item {
                let item = i as! Item
                if item.castable {
                    items.append(item)
                }
            }
        }
        return items
    }
    var confirmAction = {}
    private var _confirmButton = Button()
    var _selectedItem:Item!
}

