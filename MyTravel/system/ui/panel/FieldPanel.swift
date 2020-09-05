//
//  FieldPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class FieldPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let tp = touches.first?.location(in: self)
        for c in children {
            if c is FieldThumb && c.contains(tp!) {
                let t = c as! FieldThumb
                t.selected = true
                _clickedNode = t
                return
            }
        }
        if _editButton.contains(tp!) && nil != _clickedNode {
            let configPanel = FieldConfigPanel()
            configPanel.create(field: (_clickedNode as! FieldThumb)._field)
            configPanel.show()
            self.removeFromParent()
            return
        }
    }
    override func create() {
        super.create()
        _setButton.width = cellSize * 2.5
        _setButton.text = "设置为作战图"
        _setButton.x = _closeButton.x - (_setButton.width + _closeButton.width) / 2 - _buttonGap
        _setButton.y = _closeButton.y
        addChild(_setButton)
        _label.text = "当前作战图：\(Game.curChar._selectedField._name)"
        _editButton.text = "编辑"
        _editButton.x = _setButton.x - (_setButton.width + _closeButton.width) / 2  - _buttonGap
        _editButton.y = _setButton.y
        addChild(_editButton)
        showFields()
        
    }
    private func showFields() {
        let fields = Game.curChar._fields
        let startX = -_panelWidth / 2 + cellSize * 2
        let startY = _panelHeight / 2 - cellSize * 2
        let gap = cellSize * 3
        
        if fields.count > 0 {
            let end = getPageEnd(fields.count)
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 9
                let x = base % 9
                let t = FieldThumb()
                t.create(field: fields[i])
                t.y = startY - gap * y.toFloat()
                t.x = startX + gap * x.toFloat()
                addChild(t)
            }
        }
    }
    private var _setButton = Button()
    private var _editButton = Button()
}
