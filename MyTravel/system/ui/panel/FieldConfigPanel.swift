//
//  FieldConfigPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class FieldConfigPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func close() {
        self.removeFromParent()
        let p = FieldPanel()
        p.create()
        p.show()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if _clickedNode != nil {
            _clickedNode.selected = false
        }
        let tp = touches.first?.location(in: self)
        for s in _slots {
            if s.contains(tp!) {
                s.selected = true
                _clickedNode = s
                return
            }
        }
        if _nextButton.contains(tp!) && nil != _clickedNode {
            let readyUnits = getReadyUnits()
            if readyUnits.count >= Game.curChar._minionCount + 1 {
                let alert = Alert()
                alert.show(title: "星图承载力已达上限！")
                return 
            }
//            isHidden = true
            let p = RoleSelectPanel()
            let list = [Game.curChar] + Game.curChar._minions
            p.create(list: list as! Array<Unit>)
            Game.curStage.showPanel(p)
            p.confirmed = {
//                self.isHidden = false
                let thumb = p._clickedThumb
                let unit = thumb!._unit!
                let clickedField = self._clickedNode as! FieldSlot
                clickedField.quality = unit._quality
                clickedField.image = unit._imgUrl
                clickedField._fieldSeat._uid = unit._uid
//                clickedField.
            }
            p.canceled = {
//                self.isHidden = false
            }
        }
    }
    func create(field:Field) {
        _field = field
        createPanelbackground()
        createCloseButton()
        createPageButtons()
        _nextButton.text = "设置"
        _prevButton.text = "移除"
        _nextButton.x = _closeButton.x - _closeButton.width - _buttonGap
        _nextButton.y = _closeButton.y
        _prevButton.x = _nextButton.x - _nextButton.width - _buttonGap
        _prevButton.y = _nextButton.y
//        _prevButton.x = -_nextButton.x
        createLabel()
        createField()
        _label.text = "当前星图承载力：\(Game.curChar._minionCount + 1)（可配置作战单位数量上限）"
    }
    private func createField() {
        let offset = cellSize * 2
        let img = SKSpriteNode(texture: SKTexture(imageNamed: _field._type))
        img.size = CGSize(width: _panelHeight - cellSize * 0.5, height: _panelHeight - cellSize * 0.5)
        img.x = offset
        addChild(img)
        let startX = -(_panelWidth) / 2 + cellSize * 0.5
        let startY = (_panelHeight) / 2 - cellSize * 0.75
        let data = FieldData.data[_field._type]!
        let gap = cellSize * 0.5
        for i in 0..._field._fieldSeats.count - 1 {
            let seatData = data[i]
            let seat = _field._fieldSeats[i]
            let slot = FieldSlot()
            slot.x = seatData.displayX + offset
            slot.y = seatData.displayY
            slot.starName = seatData.starName
            slot._fieldSeat = seat
            if !seat._uid.isEmpty {
                slot.image = Game.curChar.getUnitById(id: seat._uid)!._imgUrl
            }
            addChild(slot)
            let label = Label()
            label.text = "\(seatData.starName)：\(seatData.desc)"
            label.fontSize = cellSize / 3
            label.x = startX
            label.y = startY - gap * i.toFloat()
            addChild(label)
            _slots.append(slot)
        }
    }
    private func getReadyUnits() -> Array<Unit> {
        var units = Array<Unit>()
        for s in _field._fieldSeats {
            if !s._uid.isEmpty {
                let unit = Game.curChar.getUnitById(id: s._uid)!
                units.append(unit)
            }
        }
        return units
    }
    private var _field:Field!
    private var _slots = Array<FieldSlot>()
}

