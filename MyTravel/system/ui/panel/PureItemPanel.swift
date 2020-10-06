//
//  ItemPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/14.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class PureItemPanel: Panel {
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
            let size = ceil(getItems().count.toFloat() / _pageSize.toFloat()).toInt()
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
        _pageSize = 55
        createPanelbackground()
        createLabel()
        createCloseButton()
        createPageButtons()
        _discardButton.x = _prevButton.x
        _discardButton.y = _closeButton.y
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        _equipButton.x = _prevButton.x - _prevButton.width - _buttonGap
        _equipButton.y = _prevButton.y
        _equipButton.text = "使用"
        addChild(_equipButton)
        
        addChild(_itemBox)
        showItems()
    }
    internal func getItems() -> Array<Item> {
        var items = Array<Item>()
        for i in Game.curChar!._items {
            if i is Item {
                items.append(i as! Item)
            }
        }
        return items
    }
    private func showItems() {
        let items = getItems()
        let startX = -_panelWidth / 2 + cellSize
        let startY = _panelHeight / 2 - cellSize
        let gap = cellSize * 1.25
        
        if items.count > 0 {
            let end = getPageEnd(items.count)
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 9
                let x = base % 9
                let icon = ItemIcon()
                if items[i]._showingText.isEmpty {
                    icon.iconText = items[i]._name
                } else {
                    icon.iconText = items[i]._showingText
                }
                icon.count = items[i]._count
                icon._content = items[i]
                icon.quality = items[i]._quality
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
    private var _itemBox = SKSpriteNode()
    internal var _equipButton = Button()
    internal var _discardButton = Button()
}
