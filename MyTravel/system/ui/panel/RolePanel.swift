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
    
    func create(unit:Unit) {
        _unit = unit
        createPanelbackground()
        createLabel()
        createCloseButton()
        createStatus()
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
        _strength.count = u._main.strength.toInt()
        _strength.x = image.x - _strength._width * 0.5
        _strength.y = image.y - imageSize * 0.5 - gap - _strength._height * 0.5
        addChild(_strength)
        
        _agility.iconText = "敏捷"
        _agility.count = u._main.agility.toInt()
        _agility.x = _strength.x + sGap
        _agility.y = _strength.y
        addChild(_agility)
        
        _intellect.iconText = "智力"
        _intellect.count = u._main.intellect.toInt()
        _intellect.x = _agility.x + sGap
        _intellect.y = _strength.y
        addChild(_intellect)
        
        if u._leftPoint > 0 {
            _leftPoint.iconText = "剩余"
            _leftPoint.count = u._leftPoint
            _leftPoint.x = _intellect.x + sGap
            _leftPoint.y = _strength.y
            addChild(_leftPoint)
        }
        
        _attack.iconText = "攻击"
        _attack.count = u._extended.attack.toInt()
        _attack.x = _strength.x
        _attack.y = _strength.y - sGap
        addChild(_attack)
        
        _defence.iconText = "甲"
        _defence.count = u._extended.defence.toInt()
        _defence.x = _agility.x
        _defence.y = _attack.y
        addChild(_defence)
        
        _avoid.iconText = "闪避"
        _avoid.count = u._extended.avoid.toInt()
        _avoid.x = _intellect.x
        _avoid.y = _attack.y
        addChild(_avoid)
        
        _accuracy.iconText = "命中"
        _accuracy.count = u._extended.accuracy.toInt()
        _accuracy.x = _avoid.x + sGap
        _accuracy.y = _attack.y
        addChild(_accuracy)
        
        _critical.iconText = "必杀"
        _critical.count = u._extended.critical.toInt()
        _critical.x = _accuracy.x + sGap
        _critical.y = _attack.y
        addChild(_critical)
        
        _spirit.iconText = "精神"
        _spirit.count = u._extended.spirit.toInt()
        _spirit.x = _critical.x + sGap
        _spirit.y = _attack.y
        addChild(_spirit)
        
        _lucky.iconText = "幸运"
        _lucky.count = u._extra.lucky.toInt()
        _lucky.x = _strength.x
        _lucky.y = _attack.y - sGap
        addChild(_lucky)
        
        _pennetrate.iconText = "破甲"
        _pennetrate.count = u._extra.pennetrate.toInt()
        _pennetrate.x = _defence.x
        _pennetrate.y = _lucky.y
        addChild(_pennetrate)
        
        _revenge.iconText = "复仇"
        _revenge.count = u._extra.revenge.toInt()
        _revenge.x = _avoid.x
        _revenge.y = _lucky.y
        addChild(_revenge)
        
        _rhythm.iconText = "律动"
        _rhythm.count = u._extra.rhythm.toInt()
        _rhythm.x = _accuracy.x
        _rhythm.y = _lucky.y
        addChild(_rhythm)
        
        _water.iconText = "冰"
        _water.countText = "\(u._NatrualPower.water.toInt())/\(u._NatrualResistance.water.toInt())"
        _water.x = _spirit.x + sGap
        _water.y = _strength.y
        addChild(_water)
        
        _fire.iconText = "火"
        _fire.countText = "\(u._NatrualPower.fire.toInt())/\(u._NatrualResistance.fire.toInt())"
        _fire.x = _water.x
        _fire.y = _attack.y
        addChild(_fire)
        
        _thunder.iconText = "雷"
        _thunder.countText = "\(u._NatrualPower.thunder.toInt())/\(u._NatrualResistance.thunder.toInt())"
        _thunder.x = _spirit.x + sGap
        _thunder.y = _lucky.y
        addChild(_thunder)
        
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
}
