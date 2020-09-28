//
//  Panel.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/27.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Panel:SKSpriteNode {
    internal var _panelWidth:CGFloat = 0
    internal var _panelHeight:CGFloat = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            close()
            return
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        self.zPosition = ZIndex.panel
        _panelWidth = (Size.default_cell_x_count + 3).toFloat() * cellSize
        _panelHeight = (Size.default_cell_y_count + 2).toFloat() * cellSize
        _buttonGap = cellSize * 0.4
        
    }
    internal func createLabel() {
        _label.text = "打败魔王后的生活真是平淡而又真实。"
        _label.x = -_panelWidth * 0.5
        _label.y = _panelHeight * 0.5 + 6
        _label.fontSize = 12
        addChild(_label)
    }
    
    internal func createPanelbackground() {
        _backgroundNode = createBackground(width: _panelWidth, height: _panelHeight)
        _backgroundNode.position = CGPoint(x: 0, y: 0)
        addChild(_backgroundNode)
        _backgroundNode.x = -_panelWidth
//        let v = CGVector(dx: _panelWidth, dy: 0)
//        let action = SKAction.fadeIn(withDuration: TimeInterval(Value.ui_animate_time))
        let action = SKAction.moveBy(x: _panelWidth, y: 0, duration: TimeInterval(Value.ui_animate_time))
        _backgroundNode.run(action)
    }
    
    internal func bgNodeOut() {
        let action = SKAction.moveBy(x: _panelWidth, y: 0, duration: TimeInterval(Value.ui_animate_time))
        _backgroundNode.run(action)
        _listLayer.run(action)
    }
    
    func create() {
        createPanelbackground()
        createLabel()
        createCloseButton()
        createPageButtons()
        addChild(_listLayer)
    }
    
    func createCloseButton() {
        _closeButton.text = "关闭"
        _closeButton.x = (_panelWidth - _closeButton.width) * 0.5
        _closeButton.y = (_panelHeight + cellSize) * 0.5
//        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
    }
    
    func createPageButtons() {
        _nextButton.text = "下一页"
        _nextButton.position.x = _closeButton.position.x
        _nextButton.position.y = -_closeButton.position.y
        addChild(_nextButton)
        
        _prevButton.text = "上一页"
        _prevButton.position.x = _nextButton.position.x - _nextButton.width - _buttonGap
        _prevButton.position.y = _nextButton.position.y
        addChild(_prevButton)
    }
    
    func getPageEnd(_ count:Int) -> Int {
        let pages = count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return count
    }
    func getPageStart(_ end:Int) -> Int {
        var start = (_curPage - 1) * _pageSize
        if start >= end {
            _curPage -= 1
            start = (_curPage - 1) * _pageSize
        }
        return start
    }
    func pageReload() {
        
    }
    
    internal func close() {
        Game.curStage.removePanel(self)
        closeAction()
    }
    func show() {
        Game.curStage.showPanel(self)
    }
    internal func getSelectedIcons(node:SKSpriteNode) -> Array<Icon> {
        var icons = Array<Icon>()
        for c in node.children {
            if c is Icon {
                let i = c as! Icon
                if i.selected {
                    icons.append(i)
                }
            }
        }
        return icons
    }
  

    
    internal var _backgroundNode:SKShapeNode!
//    var _lastSelectedIcon:Icon!
    internal var _label = Label()
    internal var _closeButton = Button()
    internal var _prevButton = Button()
    internal var _nextButton = Button()
    internal var _pageSize = 20
    internal var _curPage = 1
    internal var _buttonGap:CGFloat =  0
    internal var _clickedNode:QualityNode!
    internal var _listLayer = SKSpriteNode()
    var closeAction = {}
    var isChild = false
    var cancelTouch = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

