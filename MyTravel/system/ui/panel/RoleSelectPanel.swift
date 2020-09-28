//
//  RoleSelectPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class RoleSelectPanel: SubPanel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _panelWidth = (Size.default_cell_x_count).toFloat() * cellSize
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let tp = touches.first?.location(in: self)
        if nil != _clickedThumb && _clickedThumb.contains(tp!) {
            close()
            confirmed()
            return
            
        }
        if nil != _clickedThumb {
            _clickedThumb.selected = false
        }
        for c in _minionBox.children {
            if c.contains(tp!) {
                let t = c as! Thumb
                t.selected = true
                _clickedThumb = t
                return
            }
        }
        if _selectButton.contains(tp!) {
            if nil != _clickedThumb {
                close()
                confirmed()
                return
            }
        }
        if _closeButton.contains(tp!) {
            close()
            canceled()
        }
    }
    override func close() {
        self.removeFromParent()
    }
    func create(list:Array<Unit>) {
        _pageSize = 9
        _list = list
        super.create()
        addChild(_minionBox)
        showMinions()
        _label.text = "点击选择单位"
        _selectButton.text = "选择"
        _selectButton.position.x = _nextButton.position.x - _prevButton.width - _buttonGap
        _selectButton.position.y = -_prevButton.position.y
        addChild(_selectButton)
    }
    override func createPanelbackground() {
        _backgroundNode = createBackground(width: _panelWidth, height: _panelHeight)
        _backgroundNode.position = CGPoint(x: 0, y: 0)
        addChild(_backgroundNode)
    }
    private func showMinions() {
        let minions = _list
        let gapX = cellSize * 4.5
        let gapY = cellSize * 2
        let startX = -_panelWidth * 0.5 + cellSize * 2.5
        let startY = _panelHeight * 0.5 - cellSize
        
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
    private var _selectButton = Button()
    private var _list = Array<Unit>()
    var _clickedThumb:Thumb!
    var confirmed = {}
    var canceled = {}
}

