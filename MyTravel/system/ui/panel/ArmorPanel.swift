//
//  ArmorPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ArmorPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let tp = touches.first?.location(in: self)
        if _clickedNode != nil {
//            _clickedNode.selected = false
            (_clickedNode as! Icon).removeWindow()
        }
        for c in _itemBox.children {
            if c.contains(tp!) {
                let icon = c as! Icon
                if icon.x > _panelWidth * 0.25 && icon.y > 0 {
                    icon.showWIndow(pos: "left")
                } else if icon.x > _panelWidth * 0.25 && icon.y <= 0{
                    icon.showWIndow(pos: "leftTop")
                } else if icon.x < _panelWidth * 0.25 && icon.y <= 0{
                    icon.showWIndow(pos: "rightTop")
                } else {
                    icon.showWIndow()
                }
                icon.selected = !icon.selected
                _clickedNode = icon
                return
            }
        }
        
        if _nextButton.contains(tp!) {
            let size = ceil(getArmors().count.toFloat() / _pageSize.toFloat()).toInt()
            if size > _curPage {
                _curPage += 1
                pageReload()
            }
            _clickedNode = nil
            return
        }
        if _prevButton.contains(tp!) {
            if _curPage > 1 {
                _curPage -= 1
                pageReload()
            }
            _clickedNode = nil
            return
        }
        let icons = getSelectedIcons(node: _itemBox)
        if _discardButton.contains(tp!) && icons.count > 0 {
            let c = Confirm()
            c.show(title: "确定要删除这些物品吗，删除后不可恢复！", confirm: {
                
            })
            return
        }
    }
    override func create() {
        _pageSize = 45
        createPanelbackground()
        createLabel()
        createCloseButton()
        createPageButtons()
        _discardButton.x = _prevButton.x
        _discardButton.y = _closeButton.y
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        _removeButton.x = -_nextButton.x
        _removeButton.y = _nextButton.y
        _removeButton.text = "卸下"
        addChild(_removeButton)
        _equipButton.x = _prevButton.x - _prevButton.width - _buttonGap
        _equipButton.y = _prevButton.y
        _equipButton.text = "装备"
        addChild(_equipButton)
        
        createSlots()
        addChild(_itemBox)
        showItems()
    }
    override func createPanelbackground() {
        _backgroundNode = createBackground(width: _panelWidth * 0.25, height: _panelHeight)
        _backgroundNode.x = -_panelWidth * 0.375
        addChild(_backgroundNode)
        _listNode = createBackground(width: _panelWidth * 0.75 - cellSize * 0.25, height: _panelHeight)
        _listNode.x = (_panelWidth + cellSize) * 0.125
        addChild(_listNode)
    }
    private func createSlots() {
//        let bgImage = SKTexture(imageNamed: "icons").getNode(0, 0)
//        bgImage.size.width = _panelWidth * 0.25
//        bgImage.size.height = _panelHeight * 0.8
//        bgImage.alpha = 0.25
//        bgImage.x = -_panelWidth * 0.375
//        addChild(bgImage)
        
        let startY = _panelHeight / 2 - cellSize
        let startX = -_panelWidth * 0.375
        let gap = cellSize * 1.25
        _amuletSlot.x = startX
        _amuletSlot.y = startY
        addChild(_amuletSlot)
        _weaponSlot.y = _amuletSlot.y - gap
        _weaponSlot.x = _amuletSlot.x - gap
        addChild(_weaponSlot)
        _shieldSlot.y = _amuletSlot.y - gap
        _shieldSlot.x = _amuletSlot.x + gap
        addChild(_shieldSlot)
        _ringASlot.y = _weaponSlot.y - gap
        _ringASlot.x = _weaponSlot.x
        addChild(_ringASlot)
        _ringBSlot.y = _shieldSlot.y - gap
        _ringBSlot.x = _shieldSlot.x
        addChild(_ringBSlot)
        _markSlot.y = _ringBSlot.y - gap
        _markSlot.x = _amuletSlot.x
        addChild(_markSlot)
        _soulSlot.y = _markSlot.y - gap
        _soulSlot.x = _amuletSlot.x
        addChild(_soulSlot)
    }
    private func getArmors() -> Array<Armor> {
        var armors = Array<Armor>()
        for _ in 0...100 {
            let armor = Armor(Armor.Sword)
            armor.create(level: 10)
            armors.append(armor)
        }
        return armors
    }
    private func showItems() {
        let armors = getArmors()
        let startX = -cellSize * 3 + cellSize * 0.25
        let startY = _panelHeight / 2 - cellSize
        let gap = cellSize * 1.25
        
        if armors.count > 0 {
            let end = getPageEnd(armors.count)
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 9
                let x = base % 9
                let icon = ArmorIcon()
                if armors[i]._showingText.isEmpty {
                    icon.iconText = armors[i]._name
                } else {
                    icon.iconText = armors[i]._showingText
                }
                icon._content = armors[i]
                icon.quality = armors[i]._quality
                icon.position.y = startY - gap * y.toFloat()
                icon.position.x = startX + gap * x.toFloat()
                _itemBox.addChild(icon)
            }
        }
    }
    override func pageReload() {
        _itemBox.removeAllChildren()
        showItems()
    }
    private var _listNode = SKShapeNode()
    private var _amuletSlot = ArmorSlot()
    private var _weaponSlot = ArmorSlot()
    private var _shieldSlot = ArmorSlot()
    private var _ringASlot = ArmorSlot()
    private var _ringBSlot = ArmorSlot()
    private var _markSlot = ArmorSlot()
    private var _soulSlot = ArmorSlot()
    private var _itemBox = SKSpriteNode()
    private var _equipButton = Button()
    private var _removeButton = Button()
    private var _discardButton = Button()
}
