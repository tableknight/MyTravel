//
//  MinionPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class MinionPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        _pageSize = 9
        super.create()
        addChild(_minionBox)
        showMinions()
        
    }
    
    override func createPageButtons() {
        _prevButton.text = "丢弃"
        _prevButton.position.x = _closeButton.position.x - _closeButton.width - _buttonGap
        _prevButton.position.y = _closeButton.position.y
        addChild(_prevButton)
    }
    
    private func showMinions() {
        let minions = getMinions()
        let gapX = cellSize * 5
        let gapY = cellSize * 2
        let startX = -_panelWidth * 0.5 + cellSize * 3.5
        let startY = _panelHeight * 0.5 - cellSize * 1.5
        
        for i in 0...minions.count - 1 {
            let y = i / 3
            let x = i % 3
            let t = Thumb()
//            t.width = cellSize * 4.5
            t.create(unit: minions[i])
            t.quality = minions[i]._quality
            t.x = startX + x.toFloat() * gapX
            t.y = startY - y.toFloat() * gapY
            _minionBox.addChild(t)
        }
    }
    
    private func getMinions() -> Array<Creature> {
        var mms = Array<Creature>()
        for _ in 0...8 {
            let c = Creature()
            c._name = "蝴蝶"
            c._imgUrl = "test_role"
            c.create(level: 10)
            mms.append(c)
        }
        return mms
    }
    private var _minionBox = SKSpriteNode()
    private var _discardButton = Button()
}
