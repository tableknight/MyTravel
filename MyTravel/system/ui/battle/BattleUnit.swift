//
//  BattleUnit.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class BattleUnit: ValueUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _spellsHidden.append(Attack())
//        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(unit:Unit) {
        for id in unit._spellsInuse {
            _spells.append(Core.getSpellById(id: id))
        }
        for id in unit._spellsHidden {
            _spellsHidden.append(Core.getSpellById(id: id))
        }
        _unit = unit
        isChar = unit is Character
        _texture = SKTexture(imageNamed: unit._imgUrl)
//        self.size = CGSize(width: cellSize, height: cellSize * 1.5)
        if isEnemy {
            setRole(node: _texture.getNode(1, 1))
        } else {
            setRole(node: _texture.getNode(1, 2))
        }
        let barWidth = cellSize
        let barHeight = cellSize / 10
        _hpbar.create(width: barWidth, height: barHeight, value: getHitPoint() / getHitPointMax(), color: BarColor.hp, cornerRadius: 1)
        _hpbar.y = -cellSize / 3
        _hpbar.x = -barWidth / 2
        addChild(_hpbar)
        
        _mpbar.create(width: barWidth, height: barHeight, value: getMana() / getManaMax(), color: BarColor.mp, cornerRadius: 1)
        _mpbar.y = _hpbar.y - cellSize * 0.1
        _mpbar.x = _hpbar.x
        addChild(_mpbar)
        
        _label.align = "center"
        _label.verticalAlign = "center"
        _label.fontSize = cellSize / 5
        _label.fontColor = QualityColor.getColor(_unit._quality)
        _label.y = _mpbar.y - _label.fontSize
        _label.text = "Lv\(unit._level.toInt())\(unit._name)"
        addChild(_label)
        
        _animationLayer.y = cellSize / 4
        _animationLayer.zPosition = _roleNode.zPosition + 500
        _animationLayer.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        addChild(_animationLayer)
    }
    func showValue(dmg:Damage, completion:@escaping () -> Void) {
        let value = dmg._value
        self.hpLose(value: value)
        showText(text: "\(value.toInt())", color: DamageColor.DAMAGE, completion: {
            if dmg.isHeal {
            } else {
                if self.isDead() {
                    self.removeFromBattle()
                    Game.curBattle.removeIcon(bu: self)
                    self.actionDead {
                        self.removeFromParent()
                    }
                }
            }
            if Game.curBattle.gameOver() {
                
            } else {
                completion()
            }
        })
    }
    func actionAttack(completion:@escaping () -> Void) {
        let range = cellSize / 2
        var v = CGVector(dx: range, dy: 0)
        var v2 = CGVector(dx: -range, dy: 0)
        if isEnemy {
            v = CGVector(dx: -range, dy: 0)
            v2 = CGVector(dx: range, dy: 0)
        }
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.1))
        let go = SKAction.sequence([wait, move1, SKAction.wait(forDuration: TimeInterval(0.25)), move2])
        _roleNode.run(go, completion: {
            completion()
        })
    }
    func actionAttacked(completion:@escaping () -> Void) {
        let d = cellSize / 6
        var v = CGVector(dx: -d, dy: 0)
        var v2 = CGVector(dx: d, dy: 0)
        if isEnemy {
            v = CGVector(dx: d, dy: 0)
            v2 = CGVector(dx: -d, dy: 0)
        }
        let moveTo = SKAction.move(by: v, duration: 0)
        let moveBack = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.8))
        let move = SKAction.sequence([moveTo, wait, moveBack])
        
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(0))
        let fadeIn = SKAction.fadeIn(withDuration: TimeInterval(0))
        let fadeWait = SKAction.wait(forDuration: TimeInterval(0.15))
        let fadeGo = SKAction.sequence([fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn])
        let anime = SKAction.group([move, fadeGo])
        _roleNode.run(anime) {
            completion()
        }
    }
    
    func hpLose(value:CGFloat) {
        _unit._extended.hitPoint -= value
        _hpbar.setValue(value: getHitPoint() / getHitPointMax())
    }
    func isDead() ->Bool {
        if _unit._extended.hitPoint < 1 {
            return true
        }
        return false
    }
    func reset() {
        isDefend = false
    }
    func removeFromBattle() {
        let b = Game.curBattle!
        var index = b._roundUnits.firstIndex(of: self)
        //有肯能行动结束已经移除了，所以不一定找得到
        if nil != index {
            b._roundUnits.remove(at: index!)
        }
        if isEnemy {
            index = b._enemyPart.firstIndex(of: self)
            b._enemyPart.remove(at: index!)
        } else {
            index = b._playerPart.firstIndex(of: self)
            b._playerPart.remove(at: index!)
        }
    }
    func setMode(index:CGFloat = 0) {
        _modeNode = SKTexture(imageNamed: "icons").getNode(index, 2)
        _modeNode.y = cellSize / 4
        addChild(_modeNode)
    }
    func removeMode() {
        _modeNode.removeFromParent()
    }
    func select() {
        setMode(index: 1)
        setTimeout(delay: 0.75, completion: {
            self.removeMode()
        })
    }
    func animate(ao:AnimationOption, completion:@escaping () -> Void = {}) {
//        var layer:SKSpriteNode!
//        if ao.single {
//            layer = ao.targetLayer
//        } else {
//            layer = ao.selfLayer ? self._animationLayer : _battle._animationLayer
//            if !ao.selfLayer {
////                if playerPart {
////                    layer.position.y = cellSize * 5
////                } else {
////                    layer.position.y = cellSize * -2.5
////                }
//            } else {
//                layer.y = cellSize * ao.y
//                layer.size = CGSize(width: cellSize * ao.layerSize, height: cellSize * ao.layerSize)
//            }
//        }
        let layer = self._animationLayer
        var x:CGFloat = ao.startX * 4,
            y:CGFloat = ao.startY * 4,
            xSize:CGFloat = ao.pictureWidth / 48,
            ySize:CGFloat = ao.pictureheight / 48,
            frameSize = ao.frameSize
        let cut = SKAction.wait(forDuration: TimeInterval(ao.duration / 1000))
        let t = SKTexture(imageNamed: ao.imgUrl)
        var seq = Array<SKAction>()
        for _ in 0...frameSize - 1 {
            let texture = t.getCell(x, y, 4, 4)
            seq.append(SKAction.setTexture(texture))
            seq.append(cut)
            x += 4
            if x >= (xSize - 1) {
                x = 0
                y += 4
                if y >= ySize - 1 {
                    break
                }
            }
        }
        if ao.executeTimes > 1 {
            for _ in 0...ao.executeTimes - 2 {
                x = ao.startX * 4
                y = ao.startY * 4 + 3
                for _ in 0...frameSize - 1 {
                    let texture = t.getCell(x, y, 4, 4)
                    seq.append(SKAction.setTexture(texture))
                    seq.append(cut)
                    x += 4
                    if x >= (xSize - 1) {
                        x = 0
                        y += 4
                        if y >= ySize - 1 {
                            break
                        }
                    }
                }
            }
        }
        if ao.fadeOut {
            seq.append(SKAction.fadeOut(withDuration: TimeInterval(0.5)))
        } else if ao.lasting > 0 {
            seq.append(SKAction.wait(forDuration: TimeInterval(ao.lasting)))
        }
        let action = ao.repeatForever ? SKAction.repeatForever(SKAction.sequence(seq)) : SKAction.sequence(seq)
        layer.run(action) {
            layer.texture = nil
            layer.alpha = 1
            completion()
        }
    }
    func hitFire(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.imgUrl = "HitFire.png"
        self.animate(ao: ao, completion: completion)
    }
    private var _hpbar = HBar()
    private var _mpbar = HBar()
    private var _label = Label()
    private var _modeNode = SKSpriteNode()
    private var _animationLayer = SKSpriteNode()
    var _spells = Array<Spell>()
    var _spellsHidden = Array<Spell>()
    var isEnemy = false
    var isDefend = false
    var isChar = false
    var _index = 0
    var _speedCursor:CGFloat = 0
}
