//
//  RolePanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/30.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class RolePanel: Panel {
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
            (_clickedNode as! Icon).removeWindow()
        }
        for c in children {
            if c.contains(tp!) {
                if c is Icon {
                    let icon = c as! Icon
                    icon.showWIndow()
                    _clickedNode = icon
                    return
                }
            }
        }
        if _discardButton.contains(tp!) {
            let confirm = Confirm()
            confirm.show(title: "确定要丢弃吗，丢弃后不可恢复！", confirm: {
                
            }, cancel: {
                
            })
        }
    }
    
    func create(unit:Unit) {
        _unit = unit
        createPanelbackground()
        createLabel()
        createCloseButton()
        createStatus()
        if unit is Creature {
            createPageButtons()
            _nextButton.text = "下一个"
            _prevButton.text = "上一个"
            _discardButton.text = "丢弃"
            _discardButton.x = _closeButton.x - _closeButton.width - _buttonGap
            _discardButton.y = _closeButton.y
            addChild(_discardButton)
        }
    }
    private var hpbarValueText = Label()
    private var mpbarValueText = Label()
    func createStatus() {
        let gap = cellSize * 0.5
        let imageSize = cellSize * 1.5
        let image = SKTexture(imageNamed: "Actor1.png").getNode(0, 0, 3, 3)
        image.x = (-_panelWidth + imageSize) * 0.5 + gap
        image.y = (_panelHeight - imageSize) * 0.5 - gap
        image.size = CGSize(width: imageSize, height: imageSize)
        addChild(image)
        let u = _unit!
        let name = Label()
        name.text = "Lv\(u._level.toInt())[\(u._name)]"
        name.fontSize = cellSize / 3
        name.verticalAlign = "center"
        name.fontColor = QualityColor.getColor(u._quality)
        name.x = image.x + imageSize * 0.5 + gap
        name.y = image.y + imageSize * 0.25
        addChild(name)
        
        let hpbar = HBar()
        let barGap = cellSize * 0.125
        let barWidth = cellSize * 2.5
        let barHeight = cellSize / 6
        hpbar.create(width: barWidth, height: barHeight, value: 0.6, color: BarColor.hp)
        hpbar.x = name.x
        hpbar.y = name.y - name.fontSize - barGap
        addChild(hpbar)
        let mpbar = HBar()
        mpbar.create(width: barWidth, height: barHeight, value: 0.3, color: BarColor.mp)
        mpbar.x = name.x
        mpbar.y = hpbar.y - barHeight - barGap
        addChild(mpbar)
        let expbar = HBar()
        expbar.create(width: barWidth, height: barHeight, value: 0.9, color: BarColor.exp)
        expbar.x = name.x
        expbar.y = mpbar.y - barHeight - barGap
        addChild(expbar)
        
        let barFontSize:CGFloat = cellSize / 4
        hpbarValueText.text = "\(u._extended.hitPoint.toInt())/\(u._extended.hitPointMax.toInt())"
        hpbarValueText.x = hpbar.x + barWidth + 6
        hpbarValueText.y = hpbar.y - barFontSize / 2
        hpbarValueText.fontSize = barFontSize
        hpbarValueText.verticalAlign = "baseline"
        addChild(hpbarValueText)
        
        mpbarValueText.text = "\(u._extended.mana.toInt())/\(u._extended.manaMax.toInt())"
        mpbarValueText.x = hpbar.x + barWidth + 6
        mpbarValueText.y = mpbar.y - barFontSize / 2
        mpbarValueText.fontSize = barFontSize
        mpbarValueText.verticalAlign = "baseline"
        addChild(mpbarValueText)
        
        let expbarValueText = Label()
        expbarValueText.text = "\(u._exp.toInt())/\(u.expNext().toInt())"
        expbarValueText.x = hpbar.x + barWidth + 6
        expbarValueText.y = expbar.y - barFontSize / 2
        expbarValueText.fontSize = barFontSize
        expbarValueText.verticalAlign = "baseline"
        addChild(expbarValueText)
        
        let sGap = gap + _strength._width
        
        _strength.iconText = "力量"
        _strength.quality = Quality.GOOD
        _strength.count = u._main.strength.toInt()
        _strength.x = image.x - _strength._width * 0.5
        _strength.y = image.y - imageSize * 0.5 - gap - _strength._height * 0.5
        addChild(_strength)
        var desc = StatusDescription()
        desc._description = "力量：大幅提升攻击，中幅提升生命，护甲，小幅提升命中、必杀，降低精神"
        _strength._content = desc
        
        _agility.iconText = "敏捷"
        _agility.quality = Quality.GOOD
        _agility.count = u._main.agility.toInt()
        _agility.x = _strength.x + sGap
        _agility.y = _strength.y
        addChild(_agility)
        desc = StatusDescription()
        desc._description = "敏捷：大幅提升速度，中幅提升必杀、闪避、命中"
        _agility._content = desc
        
        _intellect.iconText = "智力"
        _intellect.quality = Quality.GOOD
        _intellect.count = u._main.intellect.toInt()
        _intellect.x = _agility.x + sGap
        _intellect.y = _strength.y
        addChild(_intellect)
        
        desc = StatusDescription()
        desc._description = "智力：大幅提升精神、法力，中幅提升闪避，小幅提升速度"
        _intellect._content = desc
        
        if u._leftPoint > 0 {
            _leftPoint.iconText = "未"
            _leftPoint.count = u._leftPoint
            _leftPoint.x = _intellect.x + sGap
            _leftPoint.y = _strength.y
            addChild(_leftPoint)
            desc = StatusDescription()
            desc._description = "未分配：剩余的可分配属性点"
            _leftPoint._content = desc
        }
        
        _attack.iconText = "攻击"
        _attack.count = u._extended.attack.toInt()
        _attack.x = _strength.x
        _attack.y = _strength.y - sGap
        addChild(_attack)
        desc = StatusDescription()
        desc._description = "攻击：影响物理攻击力"
        _attack._content = desc
        
        _defence.iconText = "甲"
        _defence.count = u._extended.defence.toInt()
        _defence.x = _agility.x
        _defence.y = _attack.y
        addChild(_defence)
        desc = StatusDescription()
        desc._description = "护甲：影响物理防御"
        _defence._content = desc
        
        _avoid.iconText = "闪避"
        _avoid.count = u._extended.avoid.toInt()
        _avoid.x = _intellect.x
        _avoid.y = _attack.y
        addChild(_avoid)
        desc = StatusDescription()
        desc._description = "闪避：影响躲闪物理攻击成功率"
        _avoid._content = desc
        
        _accuracy.iconText = "命中"
        _accuracy.count = u._extended.accuracy.toInt()
        _accuracy.x = _avoid.x + sGap
        _accuracy.y = _attack.y
        addChild(_accuracy)
        desc = StatusDescription()
        desc._description = "命中：影响物理攻击命中率"
        _accuracy._content = desc
        
        _critical.iconText = "必杀"
        _critical.count = u._extended.critical.toInt()
        _critical.x = _accuracy.x + sGap
        _critical.y = _attack.y
        addChild(_critical)
        desc = StatusDescription()
        desc._description = "必杀：影响物理攻击暴击率"
        _critical._content = desc
        
        _spirit.iconText = "精神"
        _spirit.count = u._extended.spirit.toInt()
        _spirit.x = _critical.x + sGap
        _spirit.y = _attack.y
        addChild(_spirit)
        desc = StatusDescription()
        desc._description = "精神：影响魔法攻击力和防御力"
        _spirit._content = desc
        
        _lucky.iconText = "幸运"
        _lucky.count = u._extra.lucky.toInt()
        _lucky.x = _strength.x
        _lucky.y = _attack.y - sGap
        addChild(_lucky)
        desc = StatusDescription()
        desc._description = "幸运：提升获取的物品品质和数量"
        _lucky._content = desc
        
        _pennetrate.iconText = "破甲"
        _pennetrate.count = u._extra.pennetrate.toInt()
        _pennetrate.x = _defence.x
        _pennetrate.y = _lucky.y
        addChild(_pennetrate)
        desc = StatusDescription()
        desc._description = "破甲：降低目标护甲"
        _pennetrate._content = desc
        
        _revenge.iconText = "复仇"
        _revenge.count = u._extra.revenge.toInt()
        _revenge.x = _avoid.x
        _revenge.y = _lucky.y
        addChild(_revenge)
        desc = StatusDescription()
        desc._description = "复仇：闪避后有一定几率反击"
        _revenge._content = desc
        
        _rhythm.iconText = "律动"
        _rhythm.count = u._extra.rhythm.toInt()
        _rhythm.x = _accuracy.x
        _rhythm.y = _lucky.y
        addChild(_rhythm)
        desc = StatusDescription()
        desc._description = "律动：高速度单位在行动之后有几率可以立即再次行动"
        _rhythm._content = desc
        
        _water.iconText = "冰"
        _water.countText = "\(u._natrualPower.water.toInt())/\(u._natrualResistance.water.toInt())"
        _water.x = _spirit.x + sGap
        _water.y = _strength.y
        addChild(_water)
        desc = StatusDescription()
        desc._description = "冰系魔法的攻击力提升\(u._natrualPower.water.toInt())%，受到的冰冷伤害降低\(u._natrualResistance.water.toInt())%"
        _water._content = desc
        
        _fire.iconText = "火"
        _fire.countText = "\(u._natrualPower.fire.toInt())/\(u._natrualResistance.fire.toInt())"
        _fire.x = _water.x
        _fire.y = _attack.y
        addChild(_fire)
        desc = StatusDescription()
        desc._description = "火系魔法的攻击力提升\(u._natrualPower.fire.toInt())%，受到的火焰伤害降低\(u._natrualResistance.fire.toInt())%"
        _fire._content = desc
        
        _thunder.iconText = "雷"
        _thunder.countText = "\(u._natrualPower.thunder.toInt())/\(u._natrualResistance.thunder.toInt())"
        _thunder.x = _spirit.x + sGap
        _thunder.y = _lucky.y
        addChild(_thunder)
        desc = StatusDescription()
        desc._description = "雷系魔法的攻击力提升\(u._natrualPower.thunder.toInt())%，受到的雷电伤害降低\(u._natrualResistance.thunder.toInt())%"
        _thunder._content = desc
        
        if u is Creature {
            let sensitive = StatusIcon()
            sensitive.iconText = "亲"
            sensitive.count = u._extra.sensitive.toInt()
            sensitive.x = _rhythm.x + sGap
            sensitive.y = _lucky.y
            addChild(sensitive)
            desc = StatusDescription()
            desc._description = "提升单位使用法术的几率"
            sensitive._content = desc
            
            let startXs = _thunder.x + cellSize * 1.875
            let startXg = _thunder.x + cellSize * 2.25 + 1
            let gapC = cellSize * 1.5
            
            let strenghStar = createColumn(value: 2.8, x: startXs, color: QualityColor.GOOD)
            addChild(strenghStar)
            let strenghGrow = createColumn(value: 2.5, x: startXg, color: QualityColor.RARE)
            addChild(strenghGrow)
            
            let agilityStar = createColumn(value: 1.5, x: startXs + gapC, color: QualityColor.GOOD)
            addChild(agilityStar)
            let agilityGrow = createColumn(value: 1.7, x: startXg + gapC, color: QualityColor.RARE)
            addChild(agilityGrow)
            
            let intStar = createColumn(value: 1.1, x: startXs + gapC * 2, color: QualityColor.GOOD)
            addChild(intStar)
            let intGrow = createColumn(value: 1.15, x: startXg + gapC * 2, color: QualityColor.RARE)
            addChild(intGrow)
            
            let line = SKShapeNode(rect: CGRect(x: _thunder.x + cellSize * 1.5, y: _thunder.y, width: cellSize * 4.5, height: 2))
            line.lineWidth = 0
            line.fillColor = UIColor.white
            addChild(line)
            
            let strLabel = Label()
            strLabel.fontSize = cellSize / 3
            strLabel.text = "力量"
            strLabel.x = startXs
            strLabel.verticalAlign = "center"
            strLabel.y = _thunder.y - strLabel.fontSize
            addChild(strLabel)
            
            let aglLabel = Label()
            aglLabel.fontSize = cellSize / 3
            aglLabel.text = "敏捷"
            aglLabel.x = startXs + gapC
            aglLabel.verticalAlign = "center"
            aglLabel.y = strLabel.y
            addChild(aglLabel)
            
            let intLabel = Label()
            intLabel.fontSize = cellSize / 3
            intLabel.text = "智力"
            intLabel.x = startXs + gapC * 2
            intLabel.verticalAlign = "center"
            intLabel.y = strLabel.y
            addChild(intLabel)
            
        }
        
        if u is Character {
            let t = FieldThumb()
            t.create(field: Game.curChar._selectedField, width: cellSize * 4, height: cellSize * 4)
            t.y = _fire.y + cellSize / 2
            t.x = _fire.x + cellSize * 4
            addChild(t)
        }
        
        _unit._spellCount = 3
        addChild(_spellNode)
        showSpells()
//        _strength.x
    }
    private func createColumn(value:CGFloat, x:CGFloat, color:UIColor) -> SKShapeNode {
        let maxHeight = cellSize * 3
        let height = maxHeight * (value / 3.6)
//        let y = -cellSize * 3 + height * 0.5
//        let y:CGFloat = 0
        let y = -cellSize * 2.5 + 1
        let column = SKShapeNode(rect: CGRect(x: x, y: y, width: cellSize / 3, height: height), cornerRadius: 2)
        column.fillColor = color
        return column
    }
    func showSpells() {
        _spellNode.removeAllChildren()
        for n in 1..._unit._spellCount {
            let icon = Icon()
            icon.x = _panelWidth * 0.5 - icon._width * 1.5 * n.toFloat()
            icon.y = _panelHeight * 0.5 - cellSize
            _spellNode.addChild(icon)
        }
    }
    func loadData() {
        
    }
    private var _unit:Unit!
    private var _strength = StatusIcon()
    private var _agility = StatusIcon()
    private var _intellect = StatusIcon()
    private var _leftPoint = StatusIcon()
    private var _attack = StatusIcon()
    private var _defence = StatusIcon()
    private var _speed = StatusIcon()
    private var _accuracy = StatusIcon()
    private var _critical = StatusIcon()
    private var _avoid = StatusIcon()
    private var _spirit = StatusIcon()
    private var _lucky = StatusIcon()
    private var _pennetrate = StatusIcon()
    private var _revenge = StatusIcon()
    private var _destory = StatusIcon()
    private var _rhythm = StatusIcon()
    private var _power = StatusIcon()
    private var _water = StatusIcon()
    private var _fire = StatusIcon()
    private var _thunder = StatusIcon()
    private var _spellNode = SKSpriteNode()
    private var _discardButton = Button()
}
