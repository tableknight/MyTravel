//
//  ArmorPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ItemPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let tp = touches.first?.location(in: self)
        if _nextButton.contains(tp!) {
            let size = ceil(getList().count.toFloat() / _pageSize.toFloat()).toInt()
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
        if _equipButton.contains(tp!) {
            if icons.count < 1 {
                return
            }
            if icons.count > 1 {
                let a = Alert()
                a.show(title: "只能选择使用一个道具！")
            }
            if icons[0]._content is Armor {
                putOn(icons[0]._content as! Armor)
            }
            return
        }
        if _clickedNode != nil {
            _clickedNode.selected = false
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
                icon.selected = true
                _clickedNode = icon
                return
            }
        }
        
        for c in _slotLayer.children {
            if c.contains(tp!) {
                let slot = c as! ArmorSlot
                slot.showWIndow()
                slot.selected = true
                _clickedNode = slot
            }
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
        _equipButton.text = "使用"
        addChild(_equipButton)
        
        addChild(_itemBox)
        addChild(_slotLayer)
        createSlots()
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
        _slotLayer.removeAllChildren()
        
        let char = Game.curChar!
        
        let startY = _panelHeight / 2 - cellSize
        let startX = -_panelWidth * 0.375
        let gap = cellSize * 1.25
        _amuletSlot.x = startX
        _amuletSlot.y = startY
        _slotLayer.addChild(_amuletSlot)
        
        if char._amulet != nil {
            _amuletSlot.content = char._amulet!
            _amuletSlot.iconText = char._amulet!._name
        }
        
        _weaponSlot.y = _amuletSlot.y - gap
        _weaponSlot.x = _amuletSlot.x - gap
        _slotLayer.addChild(_weaponSlot)
        if char._weapon != nil {
            _weaponSlot.content = char._weapon!
            _weaponSlot.iconText = char._weapon!._name
        }
        _shieldSlot.y = _amuletSlot.y - gap
        _shieldSlot.x = _amuletSlot.x + gap
        _slotLayer.addChild(_shieldSlot)
        if char._shield != nil {
            _shieldSlot.content = char._shield!
            _shieldSlot.iconText = char._shield!._name
        }
        _ringASlot.y = _weaponSlot.y - gap
        _ringASlot.x = _weaponSlot.x
        _slotLayer.addChild(_ringASlot)
        if char._leftRing != nil {
            _ringASlot.content = char._leftRing!
            _ringASlot.iconText = char._leftRing!._name
        }
        _ringBSlot.y = _shieldSlot.y - gap
        _ringBSlot.x = _shieldSlot.x
        _slotLayer.addChild(_ringBSlot)
        if char._rightRing != nil {
            _ringBSlot.content = char._rightRing!
            _ringBSlot.iconText = char._rightRing!._name
        }
        _markSlot.y = _ringBSlot.y - gap
        _markSlot.x = _amuletSlot.x
        _slotLayer.addChild(_markSlot)
        if char._magicMark != nil {
            _markSlot.content = char._magicMark!
            _markSlot.iconText = char._magicMark!._name
        }
        _soulSlot.y = _markSlot.y - gap
        _soulSlot.x = _amuletSlot.x
        _slotLayer.addChild(_soulSlot)
        if char._soulStone != nil {
            _soulSlot.content = char._soulStone!
            _soulSlot.iconText = char._soulStone!._name
        }
    }
    private func getList() -> Array<Stackable> {
//        var armors = Array<Stackable>()
        return Game.curChar._items
    }
    private func showItems() {
        let armors = getList()
        let startX = -cellSize * 3 + cellSize * 0.25
        let startY = _panelHeight / 2 - cellSize
        let gap = cellSize * 1.25
        let nEachLine = 9
        
        if armors.count > 0 {
            let end = getPageEnd(armors.count)
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / nEachLine
                let x = base % nEachLine
                let icon = ArmorIcon()
                if armors[i] is Item {
                    let item = armors[i] as! Item
                    if item._showingText.isEmpty {
                        icon.iconText = item._name
                    } else {
                        icon.iconText = item._showingText
                    }
                    icon._content = item
                    icon.quality = item._quality
                } else {
                    let armor = armors[i] as! Armor
                    if armor._showingText.isEmpty {
                        icon.iconText = armor._name
                    } else {
                        icon.iconText = armor._showingText
                    }
                    icon._content = armor
                    icon.quality = armor._quality
                }
                
                
                icon.position.y = startY - gap * y.toFloat()
                icon.position.x = startX + gap * x.toFloat()
                _itemBox.addChild(icon)
            }
        }
    }
    private func putOn(_ armor:Armor) {
        let char = Game.curChar!
        if armor.isWeapon() {
            if char._weapon != nil {
                char._weapon!.off()
                char.addItem(char._weapon!)
            }
            char._weapon = armor
            armor.on()
        } else if armor._type == Armor.Amulet {
            if char._amulet != nil {
                char._amulet!.off()
                char.addItem(char._amulet!)
            }
            char._amulet = armor
            armor.on()
        } else if armor._type == Armor.Shield {
            if char._shield != nil {
                char._shield!.off()
                char.addItem(char._shield!)
            }
            char._shield = armor
            armor.on()
        } else if armor._type == Armor.Ring {
            if char._leftRing == nil {
                char._leftRing = armor
                armor.on()
            } else if char._rightRing == nil {
                char._rightRing = armor
                armor.on()
            } else {
                char._leftRing!.off()
                char.addItem(char._leftRing!)
                char._leftRing = armor
                armor.on()
            }
        } else if armor._type == Armor.MagicMark {
            if char._magicMark != nil {
                char._magicMark!.off()
                char.addItem(char._magicMark!)
            }
            char._magicMark = armor
            armor.on()
        } else if armor._type == Armor.SoulStone {
            if char._soulStone != nil {
                char._soulStone!.off()
                char.addItem(char._soulStone!)
            }
            char._soulStone = armor
            armor.on()
        }
        char.removeItem(armor)
        pageReload()
        createSlots()
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
    private var _slotLayer = SKSpriteNode()
    private var _equipButton = Button()
    private var _removeButton = Button()
    private var _discardButton = Button()
}
