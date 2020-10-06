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
//        super.touchesBegan(touches, with: event)
        let tp = touches.first?.location(in: self)
        if nil != _clickedNode && _clickedNode.contains(tp!) {
            buttonOut {
                let configPanel = FieldConfigPanel()
                configPanel.create(field: (self._clickedNode as! FieldThumb)._field)
                configPanel.show()
                self.removeFromParent()
                configPanel.closeAction = {
//                    self.isHidden = false
                }
                return
            }
            
            return
        }
        if nil != _clickedNode {
            _clickedNode.selected = false
        }
        for c in _fieldLayer.children {
            if c is FieldThumb && c.contains(tp!) {
                let t = c as! FieldThumb
                t.selected = true
                _clickedNode = t
                return
            }
        }
        if _closeButton.contains(tp!) {
            buttonOut {
                self.close()
            }
            return
        }
        if _editButton.contains(tp!) && nil != _clickedNode {
            buttonOut {
                let configPanel = FieldConfigPanel()
                configPanel.create(field: (self._clickedNode as! FieldThumb)._field)
                configPanel.show()
                self.removeFromParent()
                return
            }
        }
        if _setButton.contains(tp!) && nil != _clickedNode {
            let field = (_clickedNode as! FieldThumb)._field!
            var hasChar = false
            for s in field._fieldSeats {
                if !s._uid.isEmpty {
                    let unit = Game.curChar.getUnitById(id: s._uid)
                    if unit is Character {
                        hasChar = true
                        break
                    }
                }
            }
            if !hasChar {
                let alert = Alert()
                alert.show(title: "星图必须配置主要角色！")
                return
            }
            Game.curChar._selectedField = field
            let alert = Alert()
            alert.show(title: "使用\(field._name)星图进行战斗")
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
        addChild(_fieldLayer)
        showFields()
        
        buttonIn()
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
                setTimeout(delay: (i + 1).toFloat() * (Value.ui_animate_time * 2), completion: {
                    self._fieldLayer.addChild(t)
                })
            }
        }
    }
    private func buttonIn() {
        let y = _panelHeight / 4
        _editButton.y += y
        _setButton.y += y
        _closeButton.y += y
        _label.y += y
        _nextButton.y -= y
        _prevButton.y -= y
        let t = TimeInterval(Value.ui_animate_time)
//        _prevButton.y += y
//        _closeButton.y += y
        let top = SKAction.move(by: CGVector(dx: 0, dy: -y), duration: t)
        let bottom = SKAction.move(by: CGVector(dx: 0, dy: y), duration: t)
        _setButton.run(top)
        _editButton.run(top)
        _closeButton.run(top)
        _prevButton.run(bottom)
        _nextButton.run(bottom)
        _label.run(top)
    }
    private func buttonOut(completion: @escaping () -> Void) {
        let t = TimeInterval(Value.ui_animate_time)
        let y = _panelHeight / 4
        let top = SKAction.move(by: CGVector(dx: 0, dy: y), duration: t)
        let bottom = SKAction.move(by: CGVector(dx: 0, dy: -y), duration: t)
        _setButton.run(top)
        _editButton.run(top)
        _closeButton.run(top)
        _prevButton.run(bottom)
        _nextButton.run(bottom) {
            completion()
        }
//        let action = SKAction.moveBy(x: _panelWidth, y: 0, duration: TimeInterval(Value.ui_animate_time))
//        _backgroundNode.run(action)
//        _fieldLayer.run(action)
//        _label.run(top, completion: completion)
    }
    private var _setButton = Button()
    private var _editButton = Button()
    private var _fieldLayer = SKSpriteNode()
}
