//
//  ValueUnit.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class ValueUnit: ActionUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _valueUnit._extended = Extended(attack: 0, defence: 0, speed: 0, accuracy: 0, critical: 0, avoid: 0, spirit: 0, hitPoint: 0, hitPointMax: 0, mana: 0, manaMax: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func getSpeed() -> CGFloat {
        return _unit._extended.speed + _valueUnit._extended.speed
    }
    func getDefence() -> CGFloat {
        return _unit._extended.defence + _valueUnit._extended.defence
    }
    func getAttack() -> CGFloat {
        return _unit._extended.attack + _valueUnit._extended.attack
    }
    func getHitPoint() -> CGFloat {
        return _unit._extended.hitPoint + _valueUnit._extended.hitPoint
    }
    func getHitPointMax() -> CGFloat {
        return _unit._extended.hitPointMax + _valueUnit._extended.hitPointMax
    }
    func getMana() -> CGFloat {
        return _unit._extended.mana + _valueUnit._extended.mana
    }
    func getManaMax() -> CGFloat {
        return _unit._extended.manaMax + _valueUnit._extended.manaMax
    }
    func getSpirit() -> CGFloat {
        return _unit._extended.spirit + _valueUnit._extended.spirit
    }
    func getMagicPower() -> CGFloat {
        return _unit._other.magicPower + _valueUnit._other.magicPower
    }
    func ringIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._leftRing?._effection == effection || c._rightRing?._effection == effection {
                return true
            }
        }
        return false
    }
    
    func markIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._magicMark?._effection == effection {
                return true
            }
        }
        return false
    }
    
    func soulstoneIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._soulStone != nil {
                if c._soulStone?._effection == effection {
                    return true
                }
            }
        }
        return false
    }
    
    func amuletIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._amulet != nil {
                if c._amulet?._effection == effection {
                    return true
                }
            }
        }
        return false
    }
    func weaponIs(_ effection:String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._weapon != nil {
                if c._weapon?._effection == effection {
                    return true
                }
                if c._weapon?._type == effection {
                    return true
                }
            }
        }
        return false
    }
    
    func shieldIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._shield != nil {
                if c._shield?._effection == effection {
                    return true
                }
            }
        }
        return false
    }
    internal var _valueUnit = Unit()
}
