//
//  Stage.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Stage: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        createUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if cancelTouch {
            return
        }
        let tp = touches.first?.location(in: self)
        if _charButton.contains(tp!) {
            hideUI {
                let p = RolePanel()
                p.create(unit: Game.curChar)
                self.showPanel(p)
            }
            return
        }
//        if _armorButton.contains(tp!) {
//            hideUI {
//                let p = ArmorPanel()
//                p.create()
//                self.showPanel(p)
//            }
//            return
//        }
        if _itemButton.contains(tp!) {
            hideUI {
                let p = ItemPanel()
                p.create()
                self.showPanel(p)
            }
            return
        }
        if _minionButton.contains(tp!) {
//            if Game.curChar._minions.count < 1 {
//                let alert = Alert()
//                alert.show(title: "没有随从可以展示！")
//                return
//            }
            hideUI {
                let p = MinionsPanel()
                p.create()
                p.show()
            }
            return
        }
        if _fieldButton.contains(tp!) {
            hideUI {
                let p = FieldPanel()
                p.create()
                self.showPanel(p)
            }
            return
        }
        if _spellButton.contains(tp!) {
            return
        }
        touchAction(tp!)
    }
    func loadScene(scene:Scene) {
        addChild(scene)
        _curScene = scene
//        _areaNameLabel.text = scene._name
    }
    func setRole(_ role:ActionUnit) {
        //        role.anchorPoint = CGPoint(x: 0, y: 0)
        role._roleNode.y = cellSize * 0.125
        role.zPosition = 1000
        role.anchorPoint = CGPoint(x: 0.5, y: 0)
        _roleX = _curScene._portalPrev.x.toInt()
        _roleY = _curScene._portalPrev.y.toInt()
        role.position.x = (-_curScene._xSize / 2 + _roleX).toFloat() * cellSize
        role.position.y = (_curScene._ySize / 2 - _roleY).toFloat() * cellSize
//        role.position.x = (-_curScene._xSize / 2 + 0).toFloat() * cellSize
//        role.position.y = (_curScene._ySize / 2 - 0).toFloat() * cellSize
        showCood()
        addChild(role)
        _playerUnit = role
    }
    private func showCood() {
        _areaNameLabel.text = "\(_curScene._name)(\(_roleX),\(_roleY))"
    }
    private func touchAction(_ point:CGPoint) {
        _targetPoint = point
        calTotalStep()
        _direction = calDirection()
        move()
    }
    private func move() {
        if shouldStop() {
            if _direction.north {
                _playerUnit.faceNorth()
            } else if _direction.south {
                _playerUnit.faceSouth()
            } else if _direction.west {
                _playerUnit.faceWest()
            } else {
                _playerUnit.faceEast()
            }
//            let point = getNextPoint()
//            let cell = _curScene.getCellType(x: point.x.toInt(), y: point.y.toInt())
//
//            let px = _roleX.toFloat() * cellSize
//            let py = _roleY.toFloat() * cellSize
//            let tx = _targetPoint.x + _curScene._xSize.toFloat() * 0.5 * cellSize
//            let ty = -_targetPoint.y + _curScene._ySize.toFloat() * 0.5 * cellSize
//            print("target x,y is \(tx),\(ty)")
//            print("role x,y is \(px),\(py)")
                    
//                    if px == point.x && py == point.y && cell == Cell.enemy {
//                        let node = _curScene.getCellNode(x: point.x.toInt(), y: point.y.toInt())
//                        node.triggerEvent()
//                        return true
//                    }
            
            return
        }
        _moving = true
        if _direction.east {
            _playerUnit.moveEast() {
                self._roleX += 1
                self.moveEndEvent()
            }
        } else if _direction.west {
            _playerUnit.moveWest() {
                self._roleX -= 1
                self.moveEndEvent()
            }
        } else if _direction.north {
            _playerUnit.moveNorth() {
                self._roleY -= 1
                self.moveEndEvent()
            }
        } else if _direction.south {
            _playerUnit.moveSouth() {
                self._roleY += 1
                self.moveEndEvent()
            }
        }
    }
    private func moveEndEvent() {
        _moving = false
        move()
        _totalStep -= 1
        showCood()
    }
    private func shouldStop() -> Bool {
        if _moving {
            return true
        }
        let px = _roleX.toFloat() * cellSize
        let py = _roleY.toFloat() * cellSize
        let tx = _targetPoint.x + _curScene._xSize.toFloat() * 0.5 * cellSize
        let ty = -_targetPoint.y + _curScene._ySize.toFloat() * 0.5 * cellSize
        
//        print("target y is \(y)")
//        print("role y is \(py)")
//
//        if px == point.x && py == point.y && cell == Cell.enemy {
//            let node = _curScene.getCellNode(x: point.x.toInt(), y: point.y.toInt())
//            node.triggerEvent()
//            return true
//        }
        
        
        if (_direction.west && _roleX < 1) || (_direction.east && _roleX >= _curScene._xSize) || (_direction.north && _roleY < 1) || (_direction.south && _roleY >= _curScene._ySize) {
            return true
        }
        
        let point = getNextPoint()
        let cell = _curScene.getCellType(x: point.x.toInt(), y: point.y.toInt())
        
//        for n in _curScene._cellLayer.children {
//            if n.contains(_targetPoint) && (abs(_playerUnit.x - n.x) <= cellSize || abs(_playerUnit.y - n.x) <= cellSize) {
//                if n is EnemyNode {
//                    let node = n as! EnemyNode
//                    node.triggerEvent() {
//                        self._curScene.setCellValue(x: point.x.toInt(), y: point.y.toInt(), value: Cell.empty)
//                        node.actionDead {
//                            node.removeFromParent()
//                        }
//                    }
//                }
//            }
//        }
        
        let size = cellSize * 1.25
        if abs(px - tx) < size && abs(py - ty) < size {
            if cell == Cell.enemy {
                let node = _curScene.getCellNode(x: point.x.toInt(), y: point.y.toInt()) as! EnemyNode
                if node.contains(_targetPoint) {
                    node.triggerEvent() {
                        self._curScene.setCellValue(x: point.x.toInt(), y: point.y.toInt(), value: Cell.empty)
                        node.actionDead {
                            node.removeFromParent()
                        }
                    }
                }
            }
        }
        
        if _totalStep < 1 {
            return true
        }
        
        if abs(px - tx) <= cellSize * 0.5 && abs(py - ty) <= cellSize * 0.5 {
            return true
        }
        
        if cell != Cell.empty && cell != Cell.portal {
            return true
        }
        return false
    }
    private func getNextPoint() -> CGPoint {
        var point = CGPoint(x: _roleX, y: _roleY)
        if _direction.north {
            point.y = _roleY.toFloat() - 1
        } else if _direction.south {
            point.y = _roleY.toFloat() + 1
        } else if _direction.west {
            point.x = _roleX.toFloat() - 1
        } else {
            point.x = _roleX.toFloat() + 1
        }
        return point
    }
    private func calTotalStep() {
        let px = _roleX.toFloat() * cellSize
        let py = _roleY.toFloat() * cellSize
        let x = _targetPoint.x + _curScene._xSize.toFloat() * 0.5 * cellSize
        let y = -_targetPoint.y + _curScene._ySize.toFloat() * 0.5 * cellSize
        
        let total = abs(px - x) + abs(py - y)
        _totalStep = (total * 1.5 / cellSize).toInt()
    }
    private func calDirection() -> Direction {
        let touchPoint = _targetPoint
        var d = Direction()
        let px = _roleX.toFloat() * cellSize
        let py = _roleY.toFloat() * cellSize
        let x = touchPoint.x + _curScene._xSize.toFloat() * 0.5 * cellSize
        let y = -touchPoint.y + _curScene._ySize.toFloat() * 0.5 * cellSize
        //y 的计算时上下反的
        let distance = (py - y) / (x - px)
        let degree = 180 * Double(atan(distance)) / .pi
        if x > px {
            if degree > 45 {
                d.north = true
//                _playerUnit.faceNorth()
            } else if degree <= 45 && degree >= -45 {
                d.east = true
                _playerUnit.faceEast()
            } else {
//                _playerUnit.faceSouth()
                d.south = true
                
                
            }
        } else {
            if degree > 45 {
                _playerUnit.faceSouth()
                d.south = true
            } else if degree <= 45 && degree >= -45 {
                d.west = true
//                _playerUnit.faceWest()
            } else {
                d.north = true
//                _playerUnit.faceNorth()
                
            }
        }
        return d
    }
    private func createUI() {
        _uiLayer.addChild(_topButtonLayer)
        _uiLayer.addChild(_infoLayer)
        _uiLayer.addChild(_buttonLayer)
//        let deviceSize = Device.getDeviceSize()
        _uiLayer.zPosition = ZIndex.ui
        _areaNameLabel.align = "center"
        _areaNameLabel.fontSize = cellSize * 0.5
        _areaNameLabel.position.y = (Size.default_cell_y_count.toFloat() - 0.75) * cellSize
        //        _areaNameLabel.position.x = (Size.default_cell_x_count.toFloat() * 0.5) * cellSize
        _uiLayer.addChild(_areaNameLabel)
        
        let lvWidth = cellSize * 0.5
        let lvCircle = LvCircle()
        lvCircle.create(radius: lvWidth, value: 12)
        lvCircle.position.x = -cellSize * (Size.default_cell_x_count + 5).toFloat() * 0.5
        lvCircle.position.y = cellSize * (Size.default_cell_y_count + 3).toFloat() * 0.5
        _infoLayer.addChild(lvCircle)
        
        let offset:CGFloat = 1
        let barWidth = cellSize * 2.5
        _hpBar.create(width: barWidth, height: cellSize / 6, value: 0.76, color: BarColor.hp, cornerRadius: 3)
        _hpBar.position.x = lvCircle.position.x + lvWidth - 1 + offset
        _hpBar.position.y = lvCircle.position.y + lvWidth * 0.75
        _infoLayer.addChild(_hpBar)
        
        _mpBar.create(width: barWidth * 0.8, height: cellSize / 8, value: 0.89, color: BarColor.mp, cornerRadius: 2)
        _mpBar.position.x = _hpBar.position.x + 2 + offset
        _mpBar.position.y = _hpBar.position.y - cellSize * 0.25
        _infoLayer.addChild(_mpBar)
        
        _expBar.create(width: barWidth * 0.75, height: cellSize / 8, value: 0.89, color: BarColor.exp, cornerRadius: 2)
        _expBar.position.x = _hpBar.position.x + 2 + offset
        _expBar.position.y = _mpBar.position.y - cellSize * 0.25 + 1
        _infoLayer.addChild(_expBar)
        
        let startX = -(Size.default_cell_x_count + 1).toFloat() * 0.5 * cellSize
        let startY = -(Size.default_cell_y_count + 4).toFloat() * cellSize * 0.5
        let startYIcon = startY + cellSize * 0.55
        
        let buttonBg = createBackground(width: (Size.default_cell_x_count + 4).toFloat() * cellSize, height: cellSize * 0.75, cornerRadius: cellSize * 0.325)
        buttonBg.position.y = startY + cellSize * 0.13
        buttonBg.strokeColor = UIColor.white
//        buttonBg.lineWidth = 1.5
        _buttonLayer.addChild(buttonBg)
        
        addChild(_uiLayer)
        
        let gap = cellSize * 3
        
        _armorButton.create(index: 0, text: "装备")
        _armorButton.position.x = startX
        _armorButton.position.y = startYIcon
        _buttonLayer.addChild(_armorButton)
        
        _fieldButton.create(index: 0, text: "星图")
        _fieldButton.position.x = startX + gap
        _fieldButton.position.y = startYIcon
        _buttonLayer.addChild(_fieldButton)
        
        _minionButton.create(index: 2, text: "随从")
        _minionButton.position.x = startX + gap * 2
        _minionButton.position.y = startYIcon
        _buttonLayer.addChild(_minionButton)
        
        _spellButton.create(index: 5, text: "法术")
        _spellButton.position.x = startX + gap * 3
        _spellButton.position.y = startYIcon
        _buttonLayer.addChild(_spellButton)
        
        _itemButton.create(index: 1, text: "道具")
        _itemButton.position.x = startX + gap * 4
        _itemButton.position.y = startYIcon
        _buttonLayer.addChild(_itemButton)
        
        _charButton.create(index: 6, text: "角色")
        _charButton.position.x = startX + gap * 5
        _charButton.position.y = startYIcon
        _buttonLayer.addChild(_charButton)
        
        let d = Device.getDeviceSize()
        
        _settingButton.create(index: 5, text: "设置", line: 1)
        _settingButton.position.x = d.width / 2 - cellSize * 2
        _settingButton.position.y = d.height / 2 - cellSize
        _topButtonLayer.addChild(_settingButton)
        
        _mapButton.create(index: 4, text: "地图", line: 1)
        _mapButton.position.x = _settingButton.x - cellSize * 1.25
        _mapButton.position.y = _settingButton.y
        _topButtonLayer.addChild(_mapButton)
        
        
        
//        let fairy = SKSpriteNode(texture: SKTexture(imageNamed: "Fairy"))
//        fairy.position.y = startY + cellSize * 1
//        fairy.position.x = startX - cellSize * 3
//        fairy.size = CGSize(width: cellSize * 1.75, height: cellSize * 3)
//        _uiLayer.addChild(fairy)
//        
//        let imp = SKSpriteNode(texture: SKTexture(imageNamed: "Imp"))
//        imp.position.y = startY + cellSize * 0.5
//        imp.position.x = -fairy.position.x
//        imp.size = CGSize(width: cellSize * 1.75, height: cellSize * 3)
//        _uiLayer.addChild(imp)
        
        let tear = SKTexture(imageNamed: "icons").getNode(3, 0)
        tear.size = CGSize(width: cellSize * 0.5, height: cellSize * 0.5)
        tear.position.x = _expBar.position.x + 4
        tear.position.y = _expBar.position.y - 9
        _infoLayer.addChild(tear)
        
        _tearCount.text = "123"
        _tearCount.position.x = tear.position.x + cellSize * 0.25
        _tearCount.position.y = tear.position.y - 6
        _tearCount.fontSize = 11
        _infoLayer.addChild(_tearCount)
        
        let gold = SKTexture(imageNamed: "icons").getNode(4, 0)
        gold.size = CGSize(width: cellSize * 0.5, height: cellSize * 0.5)
        gold.position.x = _tearCount.position.x + cellSize * 0.5 + _tearCount.width
        gold.position.y = tear.position.y
        _infoLayer.addChild(gold)
        
        _goldCount.text = "2354"
        _goldCount.position.x = gold.position.x + cellSize * 0.25
        _goldCount.position.y = _tearCount.position.y
        _goldCount.fontSize = 11
        _infoLayer.addChild(_goldCount)
    }
    func addStatus(status:Status) {
        
    }
    func showPanel(_ panel:Panel) {
        cancelTouch = true
        addChild(panel)
//        hideUI()
    }
    func hideUI(completion: @escaping () -> Void) {
        let t = TimeInterval(Value.ui_animate_time)
        let p = cellSize * 5
        let top = SKAction.move(by: CGVector(dx: 0, dy: p), duration: t)
        let bottom = SKAction.move(by: CGVector(dx: 0, dy: -p), duration: t)
        let left = SKAction.move(by: CGVector(dx: -p, dy: 0), duration: t)
        let right = SKAction.move(by: CGVector(dx: p, dy: 0), duration: t)
        _areaNameLabel.run(top) {
            self._uiLayer.isHidden = true
            completion()
        }
        _topButtonLayer.run(right)
        _infoLayer.run(left)
        _buttonLayer.run(bottom)
    }
    func showUI(completion: @escaping () -> Void) {
        let t = TimeInterval(Value.ui_animate_time)
        let p = cellSize * 5
        let top = SKAction.move(by: CGVector(dx: 0, dy: -p), duration: t)
        let bottom = SKAction.move(by: CGVector(dx: 0, dy: p), duration: t)
        let left = SKAction.move(by: CGVector(dx: p, dy: 0), duration: t)
        let right = SKAction.move(by: CGVector(dx: -p, dy: 0), duration: t)
        self._uiLayer.isHidden = false
        _areaNameLabel.run(top) {
            completion()
        }
        _topButtonLayer.run(right)
        _infoLayer.run(left)
        _buttonLayer.run(bottom)
    }
    func removePanel(_ panel:Panel) {
        cancelTouch = false
        panel.removeFromParent()
        showUI() {
            
        }
    }
    var _playerUnit:ActionUnit!
    var _curScene:Scene!
    var cancelTouch = false
    private var _totalStep = 0
    private var _roleX = 0
    private var _roleY = 0
    private var _direction:Direction!
    private var _moving = false
    private var _targetPoint = CGPoint()
    private var _uiLayer = SKSpriteNode()
    private var _areaNameLabel = Label()
    private var _infoLayer = SKSpriteNode()
    private var _topButtonLayer = SKSpriteNode()
    private var _hpBar = HBar()
    private var _mpBar = HBar()
    private var _expBar = HBar()
    private var _buttonLayer = SKSpriteNode()
    private var _armorButton = IconButton()
    private var _charButton = IconButton()
    private var _spellButton = IconButton()
    private var _itemButton = IconButton()
    private var _minionButton = IconButton()
    private var _fieldButton = IconButton()
    private var _settingButton = IconButton()
    private var _mapButton = IconButton()
    private var _tearCount = Label()
    private var _goldCount = Label()
    
    
//    private var _showingPanel:Panel!
}

class LvCircle: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(radius:CGFloat, value:Int) {
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.lineWidth = 1
        circle.strokeColor = UIColor.white
        circle.fillColor = UIColor.black
        addChild(circle)
        
        let label = Label()
        label.text = "Lv.\(value)"
        label.align = "center"
        label.position.y = -5
//        label.position.x = -
        label.fontSize = 12
        addChild(label)
    }
}
