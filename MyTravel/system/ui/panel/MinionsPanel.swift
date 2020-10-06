//
//  MinionsPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/28.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class MinionsPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if cancelTouch {
            return
        }
        let tp = touches.first?.location(in: self)
        for n in _minionBox.children {
            if n.contains(tp!) {
                let rt = n as! RoleThumb
                if rt.selected {
                    closeAnimate {
                        self.removeFromParent()
                        let rp = RolePanel()
                        rp._index = rt._index
                        rp.create(unit: rt._unit)
                        rp.show()
                    }
                    return
                }
                if nil != rt._unit {
                    if _clickedNode != nil {
                        _clickedNode.selected = false
                    }
                    rt.selected = true
                    _clickedNode = rt
                    return
                }
            }
        }
        if _closeButton.contains(tp!) {
            closeAnimate {
                self.close()
            }
        }
    }
    private func closeAnimate(completion: @escaping () -> Void) {
        let t = TimeInterval(Value.ui_animate_time)
        let left = SKAction.move(by: CGVector(dx: -_panelWidth * 0.5, dy: 0), duration: t)
        let right = SKAction.move(by: CGVector(dx: _panelWidth * 0.5, dy: 0), duration: t)
        for i in 0..._minionBox.children.count - 1 {
            if i < 5 {
                _minionBox.children[i].run(left)
            } else {
                _minionBox.children[i].run(right)
            }
        }
        let top = SKAction.move(by: CGVector(dx: 0, dy: _panelHeight / 2), duration: t)
        _prevButton.run(top)
        _label.run(top)
        _closeButton.run(top) {
            completion()
        }
    }
    override func create() {
        _pageSize = 9
        super.create()
        addChild(_minionBox)
        showMinions()
        let y = _panelHeight / 2
        _prevButton.y += y
        _closeButton.y += y
        _label.y += y
    }
    
    override func createPanelbackground() {
//        super.createPanelbackground()
    }
    
    override func createPageButtons() {
        _prevButton.text = "丢弃"
        _prevButton.position.x = _closeButton.position.x - _closeButton.width - _buttonGap
        _prevButton.position.y = _closeButton.position.y
        addChild(_prevButton)

    }
    
    private func showMinions() {
        let minions = getMinions()
        let gapX = cellSize * 1.75 - 1
        let startX = -_panelWidth * 0.5 + cellSize * 0.75
        cancelTouch = true
        for i in 0...9 {
            let t = RoleThumb()
//            t.width = cellSize * 4.5
            if i < minions.count {
                t.create(unit: minions[i])
                t.quality = minions[i]._quality
            } else {
                t.create(unit: nil)
            }
            t._index = i
            t.x = startX + i.toFloat() * gapX
            self._minionBox.addChild(t)
            t.alpha = 0
            setTimeout(delay: i.toFloat() * (Value.ui_animate_time / 10), completion: {
                let fi = SKAction.fadeIn(withDuration: TimeInterval(Value.ui_animate_time))
                t.run(fi)
                if i == 9 {
                    self.cancelTouch = false
                    self.buttonMove()
                }
            })
        }
        
    }
    private func buttonMove() {
        let t = TimeInterval(Value.ui_animate_time)
        let y = _panelHeight / 2
//        _prevButton.y += y
//        _closeButton.y += y
        let top = SKAction.move(by: CGVector(dx: 0, dy: -y), duration: t)
        _prevButton.run(top)
        _closeButton.run(top)
        _label.run(top)
    }
    
    private func getMinions() -> Array<Creature> {
        return Game.curChar._minions
    }
    private var _minionBox = SKSpriteNode()
    private var _discardButton = Button()
}

