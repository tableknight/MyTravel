//
//  Battle.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Battle: SKSpriteNode {
    static let ACTION_ATTACK = 1
    static let ACTION_DEFEND = 2
    static let ACTION_ITEM = 3
    static let ACTION_SELECT_TARGET_SELF = 10
    static let ACTION_SELECT_TARGET_ENEMY = 11
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if cancelTouch {
            return
        }
        
        let tp = touches.first?.location(in: self)
        if _autoAction.contains(tp!) {
            if Game.curChar.autoAction {
                Game.curChar.autoAction = false
            } else {
                Game.curChar.autoAction = true
                if _curUnit.isChar {
                    createAction()
                }
            }
            _autoAction.selected = Game.curChar.autoAction
            return
        }
        if _curUnit.isChar {
            for i in 0..._infoSquare.children.count - 1 {
                if _infoSquare.children[i].contains(tp!) {
                    let action = _infoSquare.children[i] as! ActionIcon
                    if 0 == i {
                        _actionMode = Battle.ACTION_ATTACK
                        _infoSquare.isHidden = true
                        _cancelAction.isHidden = false
                        setModeSelect(isSelf: false)
                    } else if 1 == i {
                        action.selected = true
                        _infoSquare.isHidden = true
                        action._spell.cast {
                            self.afterMove()
                        }
                    } else if 2 == i {
                        cancelTouch = true
                        _infoSquare.isHidden = true
                        let itemPanel = ItemSelectPanel()
                        itemPanel.create()
                        itemPanel.zPosition = self.zPosition + 300
                        addChild(itemPanel)
                        itemPanel.closeAction = {
                            self.cancelTouch = false
                            self._infoSquare.isHidden = false
                        }
                        itemPanel.confirmAction = {
                            self._cancelAction.isHidden = false
                            let item = itemPanel._selectedItem!
                            if item.autoCast {
                                item.cast {
                                    self.afterMove()
                                }
                            } else {
                                //                                self._actionMode = Battle.ACTION_SELECT_TARGET
                                //                                self.setModeSelect(isSelf: item.castSelf)
                            }
                        }
                        
                    } else if 3 == i {
                        
                    } else if 4 == i {
                        
                    } else {
                        let spell = action._spell!
                        if spell.autoCast {
                            spell.cast {
                                self.afterMove()
                            }
                        } else {
                            if spell.castSelf {
                                _actionMode = Battle.ACTION_SELECT_TARGET_SELF
                            } else {
                                _actionMode = Battle.ACTION_SELECT_TARGET_ENEMY
                            }
                            setModeSelect(isSelf: spell.castSelf)
                            hideActions()
                            showCancel()
                            return
                        }
                    }
                    break
                }
            }
        }
        if _actionMode == Battle.ACTION_ATTACK {
            for u in _enemyPart {
                if u.contains(tp!) {
                    removeAllMode()
                    _cancelAction.isHidden = true
//                    _infoSquare.isHidden = false
                    _actionMode = -1
                    u.select()
                    let a = Attack()
                    a._targets.append(u)
                    a.cast {
                        self.afterMove()
                    }
                    break
                }
            }
        }
        if _actionMode == Battle.ACTION_ITEM {
            
            
        }
        if _cancelAction.contains(tp!) && !_cancelAction.isHidden {
            showActions()
            hideCancel()
            clearUnitModeAll()
            return
        }
        
    }
    private func hideActions() {
        _infoSquare.isHidden = true
    }
    private func showActions() {
        _infoSquare.isHidden = false
    }
    private func showCancel() {
        _cancelAction.isHidden = false
    }
    private func hideCancel() {
        _cancelAction.isHidden = true
    }
    private func setModeSelect(isSelf:Bool = false) {
        if isSelf {
            for u in _playerPart {
                u.setMode(index: 0)
            }
        } else {
            for u in _enemyPart {
                u.setMode(index: 0)
            }
        }
    }
    private func removeAllMode() {
        for u in _playerPart + _enemyPart {
            u.removeMode()
        }
    }
    private func clearUnitModeAll() {
        for u in _playerPart + _enemyPart {
            u.removeMode()
        }
    }
    private let _enterGroundTime:CGFloat = 0.6
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        self.zPosition = ZIndex.panel
        let size = Device.getDeviceSize()
        let mask = createBackground(width: size.width, height: size.height)
        mask.lineWidth = 0
        mask.alpha = 0.85
        addChild(mask)
        _moveOffset = cellSize * 5
        addChild(_playerNode)
        addChild(_enemyNode)
        addChild(_unitIconBox)
        addBaseUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func start() {
        Game.curStage.cancelTouch = true
        Game.curBattle = self
        Game.curStage.hideUI() {
            
        }
        Game.curStage.addChild(self)
        addPlayerUnits()
        setTimeout(delay: 2) {
            self.calSpeedLine()
            self.beforeMove()
        }
    }
    func end() {
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(1))
        _playerNode.removeFromParent()
        _enemyNode.removeFromParent()
        self.run(fadeOut) {
            Game.curStage.cancelTouch = false
            Game.curBattle = nil
            Game.curStage.showUI() {
                
            }
            self.removeFromParent()
        }
    }
    private func addBaseUI() {
        let width = Device.getDeviceSize().width
        let square = createBackground(width: width, height: 2)
        square.lineWidth = 0
        square.fillColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
        square.y = -cellSize * 3
        let bgNode = createBackground(width: width, height: cellSize * 2)
        bgNode.lineWidth = 0
        bgNode.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        bgNode.y = -cellSize * 4
        addChild(bgNode)
        addChild(square)
        addChild(_infoSquare)
        let iconTexture = SKTexture(imageNamed: "icons")
        _autoAction.x = Device.getDeviceSize().width / 2 - cellSize * 2
        _autoAction.y = cellSize * 4
        _autoAction.image = iconTexture.getNode(5, 3)
        _autoAction.actionName = "自动"
        _autoAction._spell = Cancel()
        addChild(_autoAction)
        if Game.curChar.autoAction {
            _autoAction.selected = true
        }
    }
    private func roundStart() {
        //        calSpeedLine()
        ////        let units = _playerPart + _enemyPart
        ////        orderUnit(units: units)
        //        addUnitIcon()
        //        beforeMove()
    }
    private func findNextUnit() {
        let all = _playerPart + _enemyPart
        for u in all {
            u._speedCursor += u.getSpeed()
        }
        for u in all {
            if u._speedCursor >= _speedLine {
                _curUnit = u
                u._speedCursor = u._speedCursor - _speedLine
                return
            }
        }
        findNextUnit()
    }
    private func addUnitIcon() {
        _unitIconBox.removeAllChildren()
        let device = Device.getDeviceSize()
        let y = -cellSize * 2.5 - 1
        let startX:CGFloat = -device.width / 2 + cellSize * 1.75
        let gap = cellSize * 0.75 + 3
        var i:CGFloat = 0
        for u in _roundUnits {
            let icon = UnitIcon()
            icon.image = u._unit._imgUrl
            icon.x = startX + i * gap
            icon.y = y
            icon._unit = u._unit
            icon.quality = u._unit._quality
            _unitIconBox.addChild(icon)
            i += 1
        }
    }
    func removeIcon(bu:BattleUnit) {
        for u in _unitIconBox.children {
            let icon = u as! UnitIcon
            if icon._unit._uid == bu._unit._uid {
                icon.removeFromParent()
                break
            }
        }
    }
    private func setIconSelected(bu:BattleUnit) {
        //        _curUnit.select()
        for u in _unitIconBox.children {
            let icon = u as! UnitIcon
            if icon._unit._uid == bu._unit._uid {
                icon.selected = true
            } else {
                icon.selected = false
            }
        }
    }
    
    private func beforeMove() {
        _roundUnits.removeAll()
        findNextUnit()
        orderUnit(units: _playerPart + _enemyPart)
        _roundUnits.insert(_curUnit, at: 0)
        addUnitIcon()
        setIconSelected(bu:_curUnit)
        createActionOptions()
        //        return
        var beforeCastSpells = Array<Spell>()
        for s in _curUnit._spells + _curUnit._spellsHidden {
            if s.isBeforeMove {
                beforeCastSpells.append(s)
            }
        }
        if beforeCastSpells.count > 0 {
            castBeforeMove(spells: beforeCastSpells)
        } else {
            moveStart()
        }
    }
    private func castBeforeMove(spells:Array<Spell>) {
        var spells = spells
        let first = spells.removeFirst()
        first.cast {
            if spells.count > 0 {
                self.castBeforeMove(spells: spells)
            } else {
                self.moveStart()
            }
        }
    }
    
    private func moveStart() {
        if _curUnit._unit is Character && !Game.curChar.autoAction {
            
        } else {
            createAction()
        }
    }
    
    private func createAction() {
        var spellIcons = Array<ActionIcon>()
        let attackIcon = _infoSquare.children[0] as! ActionIcon
        let defendIcon = _infoSquare.children[1] as! ActionIcon
        if _infoSquare.children.count > 2 {
            for i in 2..._infoSquare.children.count - 1 {
                let c = _infoSquare.children[i]
                if c is ActionIcon {
                    let icon = c as! ActionIcon
                    if icon.notForAuto {
                        continue
                    }
                    icon.selected = false
                    spellIcons.append(icon)
                }
            }
        }
        let sed = seed().toFloat()
        var spellIcon = attackIcon
        if sed < _curUnit.getSensitive() && spellIcons.count > 0 {
            spellIcon = spellIcons.one()
        } else {
            if sed < 25 {
                spellIcon = defendIcon
            } else {
                spellIcon = attackIcon
            }
        }
        spellIcon.selected = true
        let spell = spellIcon._spell!
        spell.findTarget()
        spell.cast {
            self.afterMove()
        }
    }
    private func afterMove() {
        var afterCastSpells = Array<Spell>()
        for s in _curUnit._spells + _curUnit._spellsHidden {
            if s.isAfterMove {
                afterCastSpells.append(s)
            }
        }
        if afterCastSpells.count > 0 {
            castAfterMove(spells: afterCastSpells)
        } else {
            moveEnd()
        }
    }
    private func castAfterMove(spells:Array<Spell>) {
        var spells = spells
        let first = spells.removeFirst()
        first.cast {
            if spells.count > 0 {
                self.castBeforeMove(spells: spells)
            } else {
                self.moveStart()
            }
        }
    }
    private func moveEnd() {
        _curUnit.reset()
//                _curUnit.removeMode()
        //        if _roundUnits.count < 1 {
        //            roundStart()
        //        } else {
        //        }
        beforeMove()
    }
    private func orderUnit(units:Array<BattleUnit>) {
        var units = units
        if units.count < 1 {
            return
        }
        var max:CGFloat = 0
        var index = 0
        for i in 0...units.count - 1 {
            let u = units[i]
            if u._speedCursor > max {
                max = u._speedCursor
                index = i
            }
        }
        if units[index] != _curUnit {
            _roundUnits.append(units[index])
        }
        units.remove(at: index)
        orderUnit(units: units)
    }
    private func calSpeedLine() {
        _speedLine = 0
        let units = _playerPart + _enemyPart
        for u in units {
            _speedLine += u.getSpeed()
        }
        _speedLine *= units.count.toFloat()
    }
    //    private func calcSpeedLine() {
    //        _speedLine = 0
    //        for u in _roundUnits {
    //            _speedLine += u.getSpeed()
    //        }
    //
    //    }
    private func addPlayerUnits() {
        setTimeout(delay: _enterGroundTime, completion: self.addPlayerUnitsDelay)
    }
    private func addPlayerUnitsDelay() {
        let c = Game.curChar!
        let offset = cellSize * 4
        let offsetY = cellSize
        for s in c._selectedField._fieldSeats {
            if !s._uid.isEmpty {
                let bu = BattleUnit()
                bu.create(unit: c.getUnitById(id: s._uid)!)
                bu.x = s._x - offset
                bu.y = s._y + offsetY
                _playerNode.addChild(bu)
                _playerPart.append(bu)
                bu.moveEastSlience()
                bu._index = s._index
            }
        }
        _playerNode.x = -_moveOffset
        let run = SKAction.move(by: CGVector(dx: _moveOffset, dy: 0), duration: TimeInterval(0.6))
        _playerNode.run(run)
    }
    func setEnemies(parts:Array<Creature>) {
        unchangedEnemyParts = parts.clone() as! Array<Creature>
        setTimeout(delay: _enterGroundTime, completion: {
            self.setEnemiesDelay(parts: parts)
        })
    }
    func setEnemiesDelay(parts:Array<Creature>) {
        let offset = cellSize * 4
        let offsetY = cellSize
        let field = Field(type: Field.Sagittarius)
        var seats = field._fieldSeats.clone() as! Array<FieldSeat>
        //        let total = seats.count + 1
        for u in parts {
            let index = seats.random()
            let seat = seats[index]
            let bu = BattleUnit()
            bu.isEnemy = true
            bu.create(unit: u)
            bu.x = -seat._x + offset
            bu.y = seat._y + offsetY
            _enemyNode.addChild(bu)
            seats.remove(at: index)
            _enemyPart.append(bu)
            bu.moveWestSlience()
            //            bu._index = total - seat._index
            bu._index = seat._index
            print("enemy x \(bu.x.toInt()) , index \(bu._index)")
            //            seats[index]._uid = u._uid
        }
        _enemyNode.x = _moveOffset
        let run = SKAction.move(by: CGVector(dx: -_moveOffset, dy: 0), duration: TimeInterval(0.6))
        _enemyNode.run(run)
    }
    private func createActionOptions() {
        _infoSquare.removeAllChildren()
        _infoSquare.isHidden = false
        //        let img = SKTexture(imageNamed: _curUnit._unit._imgUrl).getNode(1, 0)
        //        img.x = -width / 2 + cellSize * 2
        //        img.y = -cellSize * 3.75
        //        _infoSquare.addChild(img)
        let width = Device.getDeviceSize().width
        let gap = cellSize * 0.875
        let startX = -width / 2 + cellSize * 0.875
        let y = -cellSize * 3.625
        
        let iconTexture = SKTexture(imageNamed: "icons")
        
        let attackAction = ActionIcon()
        attackAction.x = startX + gap
        attackAction.y = y
        attackAction.image = iconTexture.getNode(0, 3)
        attackAction.actionName = "攻击"
        attackAction._spell = Attack()
        _infoSquare.addChild(attackAction)
        
        let defenceAction = ActionIcon()
        defenceAction.x = startX + gap * 2
        defenceAction.y = y
        defenceAction.image = iconTexture.getNode(1, 3)
        defenceAction.actionName = "防御"
        defenceAction._spell = Defend()
        _infoSquare.addChild(defenceAction)
        
        var spellGapStart:CGFloat = 3
        
        if _curUnit.isChar {
            let itemAction = ActionIcon()
            itemAction.x = startX + gap * 3
            itemAction.y = y
            itemAction.image = iconTexture.getNode(4, 3)
            itemAction.actionName = "道具"
            itemAction._spell = UseItem()
            itemAction.notForAuto = true
            _infoSquare.addChild(itemAction)
            
            let summonAction = ActionIcon()
            summonAction.x = startX + gap * 4
            summonAction.y = y
            summonAction.image = iconTexture.getNode(2, 3)
            summonAction.actionName = "召唤"
            summonAction._spell = Summon()
            summonAction.notForAuto = true
            _infoSquare.addChild(summonAction)
            
            let withdrawAction = ActionIcon()
            withdrawAction.x = startX + gap * 5
            withdrawAction.y = y
            withdrawAction.image = iconTexture.getNode(3, 3)
            withdrawAction.actionName = "召回"
            withdrawAction._spell = Withdraw()
            withdrawAction.notForAuto = true
            _infoSquare.addChild(withdrawAction)
            
            spellGapStart = 6
            
            _cancelAction.removeFromParent()
            _cancelAction.x = -attackAction.x
            _cancelAction.y = y
            _cancelAction.image = iconTexture.getNode(5, 3)
            _cancelAction.actionName = "取消"
            _cancelAction._spell = Cancel()
            _cancelAction.isHidden = true
            _cancelAction.notForAuto = true
            addChild(_cancelAction)
        }
        var i:CGFloat = 0
        for s in _curUnit._spells {
            let spellAction = ActionIcon()
            spellAction.x = startX + gap * (spellGapStart + i)
            spellAction.y = y
            spellAction.iconText = s._name
            spellAction.actionName = s._name
            spellAction._spell = s
            _infoSquare.addChild(spellAction)
            i += 1
        }
    }
    func gameOver() -> Bool {
        if Game.curChar._extended.hitPoint < 1 {
            return true
        }
        if _playerPart.count < 1 {
            FailedResult()
            return true
        }
        if _enemyPart.count < 1 {
            VictoryResult()
            return true
        }
        return false
    }
    func VictoryResult() {
        end()
        victoryAction()
    }
    func FailedResult() {
        end()
        failedAction()
    }
    var _playerPart = Array<BattleUnit>()
    var _enemyPart = Array<BattleUnit>()
    var unchangedEnemyParts = Array<Creature>()
    private var _round = 1
    private var _moveOffset:CGFloat = 0
    private var _playerNode = SKSpriteNode()
    private var _enemyNode = SKSpriteNode()
    private var _infoSquare = SKSpriteNode()
    var _actionMode = -1
    //    private var _speedLine:CGFloat = 0
    var _roundUnits = Array<BattleUnit>()
    var _curUnit:BattleUnit!
    var victoryAction = {}
    var failedAction = {}
    private var _unitIconBox = SKSpriteNode()
    var _cancelAction = ActionIcon()
    var _autoAction = ActionIcon()
    private var cancelTouch = false
//    private var isAuto = false
    private var _speedLine:CGFloat = 0
    //    var _targets = Array<BattleUnit>()
}
