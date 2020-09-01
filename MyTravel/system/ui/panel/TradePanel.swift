//
//  TradePanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class TradePanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createPanelbackground() {
        let gap = cellSize * 0.5
        let width = _panelWidth * 0.5 - gap * 0.5
        _backgroundNode = createBackground(width: width, height: _panelHeight)
        _backgroundNode.x = (-_panelWidth + width) * 0.5
        addChild(_backgroundNode)
        
        _listBackgroundNode = createBackground(width: width, height: _panelHeight)
        _listBackgroundNode.x = (width + gap) * 0.5
        addChild(_listBackgroundNode)
        
        
    }
    override func create() {
        super.create()
        createTradeButton()
    }
    internal func createTradeButton() {
        _buyButton.x = -_nextButton.x
        _buyButton.y = _nextButton.y
        _buyButton.text = "购买"
        addChild(_buyButton)
        
        _sellButton.x = _prevButton.x - _prevButton.width - _buttonGap
        _sellButton.y = _nextButton.y
        _sellButton.text = "出售"
        addChild(_sellButton)
    }
    internal var _listBackgroundNode = SKShapeNode()
    internal var _buyButton = Button()
    internal var _sellButton = Button()
}
