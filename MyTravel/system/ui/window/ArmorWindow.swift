//
//  ArmorWindow.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ArmorWindow: Window {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create(item:Showable) {
        let armor = item as! Armor
        let z = self.zPosition + 200
        
        let name = Label()
        var nameText = armor._name
        if armor._quality == Quality.SACRED {
            nameText = getOutfitNameText(armor._type) + " · " + armor._name
        }
        if armor._type == Armor.MagicMark || armor._type == Armor.Instrument {
//            nameText = getOutfitNameText(armor._type) + " · " + Loot.getSpellById(armor._spell)._name
        } else if armor._type == Armor.Instrument {
            nameText = getOutfitNameText(armor._type)
        }
        name.text = "Lv\(armor._level) [\(nameText)]"
        name.fontSize = 16
        name.fontColor = QualityColor.getColor(armor._quality)
        name.zPosition = z
        addChild(name)
        
        width = (name.text.count - 1).toFloat() * name.fontSize
        height = cellSize + name.fontSize
        
        let spd = Label()
        if armor._attackSpeed > 0 {
            let speedText = "\(armor._attackSpeed)"
            var str = ""
            var i = 0
            for c in speedText {
                if i < 4 {
                    str.append(c)
                }
                i += 1
            }
            spd.text = "攻速 \(str)"
            spd.zPosition = z
            spd.fontColor = UIColor.white
            spd.fontSize = cellSize / 4
            height += cellSize / 3
            addChild(spd)
        }
        
        var attrs = Array<Label>()
        let attrGap = cellSize / 12
        if armor._attrs.count > 0 {
            for i in 0...armor._attrs.count - 1 {
                if armor._attrs[i]._hidden {
                    continue
                }
                let label = Label()
                label.fontSize = cellSize / 3
                //                label.fontName = ""
                label.text = armor._attrs[i].getText()
                label.fontColor = UIColor.white
                label.zPosition = z
                addChild(label)
                attrs.append(label)
                height += name.fontSize + attrGap
            }
        }
        
        let spellText = Label()
        spellText.fontSize = cellSize / 3.6
        if !armor._spellText.isEmpty {
            spellText.text = "[\(armor._spellText)]"
            spellText.fontColor = QualityColor.getColor(armor._quality)
            height += cellSize / 2
            spellText.zPosition = z
            addChild(spellText)
        }
        
        let des = Label()
        des.fontSize = cellSize / 3.6
        if !armor._description.isEmpty {
            des.text = armor._description
            des.fontColor = QualityColor.GOOD
            height += cellSize / 3
            des.zPosition = z
            addChild(des)
        } else if armor._type == Armor.MagicMark || armor._type == Armor.Instrument {
//            let s = Loot.getSpellById(armor._spell)
//            let des = Label()
//            des.text = s._description
//            des.fontColor = QualityColor.NORMAL
        }
        
        let price = Label()
        if armor._price > 0 {
            price.fontSize = cellSize / 4
            price.text = "出售价格：\(armor._price)G"
            price.fontColor = UIColor.orange
            price.zPosition = z
            addChild(price)
        }
        
        name.position.x = -width * 0.5 + cellSize * 0.25
        name.position.y = (height - cellSize - name.fontSize) * 0.5
        var lastY = name.y - cellSize / 6
        
        if armor._attackSpeed > 0 {
            spd.x = name.x
            spd.y = name.y - cellSize / 2.5
            lastY = name.y - cellSize / 2
        }
        
        
        
        if attrs.count > 0 {
            for a in attrs {
                a.x = name.x
                a.y = lastY - (attrGap + cellSize / 3)
                lastY = a.y
            }
            lastY -= cellSize / 6
            height += cellSize / 6
        }
        height += cellSize / 6
        if !spellText.text.isEmpty {
            height += cellSize / 6
            spellText.x = spellText.x
            spellText.y = lastY - cellSize / 3
            lastY = spellText.y
        }
        if !des.text.isEmpty {
            des.x = name.x
            des.y = lastY - cellSize / 3
            lastY = des.y
        }
        
        if armor._price > 0 {
            price.x = name.x
            price.y = lastY - cellSize / 3
        }
        
        _backgroundNode = createBackground(width: self.width, height: self.height)
        _backgroundNode.alpha = 1
        addChild(_backgroundNode)
    }
    private func getOutfitNameText(_ type:String) -> String {
        if type ==  Armor.Amulet {
            return "项链"
        }
        if type ==  Armor.Shield {
            return "盾"
        }
        if type ==  Armor.Ring {
            return "戒指"
        }
        if type ==  Armor.MagicMark {
            return "魔印"
        }
        if type ==  Armor.SoulStone {
            return "灵魂石"
        }
        if type ==  Armor.Sword {
            return "剑"
        }
        if type ==  Armor.Wand {
            return "法杖"
        }
        if type ==  Armor.Instrument {
            return "法器"
        }
        if type ==  Armor.Dagger {
            return "匕首"
        }
        if type ==  Armor.Fist {
            return "拳套"
        }
        if type ==  Armor.Blunt {
            return "钝器"
        }
        if type ==  Armor.Bow {
            return "弓"
        }
        if type ==  Armor.EarRing {
            return "耳环"
        }
        return ""
    }
}

