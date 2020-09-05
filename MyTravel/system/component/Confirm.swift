//
//  Confirm.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Confirm: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tp = touches.first?.location(in: self)
        if _confirmButton.contains(tp!) {
            self.removeFromParent()
            self.confirmed()
        }
        if _cancelButton.contains(tp!) {
            self.removeFromParent()
            self.canceled()
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = ZIndex.confirm
        self.isUserInteractionEnabled = true
        let bNode = createBackground(width: cellSize * 7, height: cellSize * 3)
        addChild(bNode)
        _label.fontSize = cellSize / 3
        _label.align = "center"
        _label.y = cellSize / 3
        addChild(_label)
        _confirmButton.x = cellSize * 1.25
        _confirmButton.y = -cellSize / 3 * 2
        _confirmButton.text = "确定"
        addChild(_confirmButton)
        _cancelButton.x = -_confirmButton.x
        _cancelButton.y = _confirmButton.y
        _cancelButton.text = "取消"
        addChild(_cancelButton)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func show(title:String, confirm:@escaping () -> Void = {}, cancel:@escaping () -> Void = {}) {
        self.title = title
        self.confirmed = confirm
        self.canceled = cancel
        Game.curStage.addChild(self)
    }
    var title:String {
        set {
            _label.text = newValue
        }
        get {
            return ""
        }
    }
    var confirmed = {}
    var canceled = {}
    private var _label = Label()
    private var _confirmButton = Button()
    private var _cancelButton = Button()
}
