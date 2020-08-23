//
//  Dungeon.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/13.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Dungeon: Scene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        super.create()
        _enemyCount = seed(min: 5, max: 8)
        findVisiblePoints()
        createPortals()
        createEnemy()
//        addCell(x: 0, y: 0, item: WallNodeTree(), z: ZIndex.item)
        //        let node = EnemyNode()
        //        node.setRole(node: SKTexture(imageNamed: "Outside").getNode(0, 1))
        //        addCell(x: 0, y: 0, item: node)
        //        let node = SKTexture(imageNamed: "Outside").getNode(0, 1)
        //        let enemy = SKTexture(imageNamed: "green_spirit").getNode(0, 1)
        //        enemy.anchorPoint = CGPoint(x: 0.5, y: 0)
        //        let e2 = SKTexture(imageNamed: "green_spirit").getNode(1, 3)
        //        e2.anchorPoint = CGPoint(x: 0.5, y: 0)
        //        e2.position.y = cellSize
        //        e2.zPosition = 200
        //        node.addChild(e2)
        //        node.addChild(enemy)
        //        node.size = CGSize(width: cellSize, height: cellSize * 2)
        //        addCell(x: 0, y: 1, item: node, z:ZIndex.enemy)
        
    }
    override func createMatrix() {
        _mapMatrix = []
        for _ in 0..._ySize {
            var row:Array<Int> = []
            for _ in 0..._xSize {
                row.append(Cell.empty)
            }
            _mapMatrix.append(row)
        }
        for y in 0..._ySize {
            for x in 0..._xSize {
                if y % 3 == 0 && x % 3 == 0  {
                    let landFragment = LandFragment.one()
                    for i in 0...landFragment.count - 1 {
                        if i % 2 == 0 {
                            let x0 = x + landFragment[i]
                            let y0 = y + landFragment[i + 1]
                            if x0 <= _xSize && y0 <= _ySize {
                                addWallCell(x: x0, y: y0)
                                //                                addCell(x: x0, y: y0, item: getCellItem(), z: ZIndex.item)
                                //                                _mapMatrix[y0][x0] = Cell.wall
                            }
                        }
                    }
                }
            }
        }
    }
    
    internal var _herbCount = 0
    internal var _maxHerbCount = 5
    internal var _chestCount = 0
    internal var _maxChestCount = 3
    internal var _towerCount = 0
    internal func addWallCell(x:Int, y:Int) {
        let sd = seed()
        let item = CellNode()
        if sd < 6 && _herbCount < _maxHerbCount && !(self is InnerMaze) {
            let herb = _herbs.one()
            item._key = herb
            let data = ItemData.data[herb]!
            let t = SKTexture(imageNamed: "Outside_B").getNode(data.imgX, data.imgY).toTexture()
            item.setTexture(t)
            addCell(x: x, y: y, item: item, z: ZIndex.item + y.toFloat() * 100)
            _mapMatrix[y][x] = Cell.herb
            _herbCount += 1
        } else if sd < 10 && _chestCount < _maxChestCount {
            let chest = Chest()
            addCell(x: x, y: y, item: chest, z: ZIndex.item + y.toFloat() * 100)
            _mapMatrix[y][x] = Cell.chest
            _chestCount += 1
        } else if sd < 15 && _towerCount < 2 {
            let tower = getRandomTower()
            addCell(x: x, y: y, item: tower, z: ZIndex.item + y.toFloat() * 100)
            _mapMatrix[y][x] = Cell.tower
            _towerCount += 1
        }
        else {
            addCell(x: x, y: y, item: WallNodeTree())
            _mapMatrix[y][x] = Cell.wall
        }
        //        else if sd < 10 && _chestCount < _maxChestCount {
        //            let chest = Chest()
        //            addWall(x: x, y: y, item: chest)
        //            _mapMatrix[y.toInt()][x.toInt()] = CELL_BOX
        //            _chestCount += 1
        //        } else if sd < 15 && _towerCount < 2 {
        //            let tower = getRandomTower()
        //            addWall(x: x, y: y, item: tower)
        //            _mapMatrix[y.toInt()][x.toInt()] = CELL_TOWER
        //            _towerCount += 1
        //        } else {
        //            item.setTexture(texture)
        //            addWall(x: x, y: y, item: item)
        //            _mapMatrix[y.toInt()][x.toInt()] = CELL_ITEM
        //        }
    }
    
    internal func getRandomTower() -> Tower {
//        return FireEnergeTower()
        let TOWER_FIRE_ENERGE = 200
        let TOWER_WATER_ENERGE = 201
        let TOWER_THUNDER_ENERGE = 202
        let TOWER_TIME_REDUCE = 203
        let TOWER_PHYSICAL_POWER = 204
        let TOWER_MAGICAL_POWER = 205
        let TOWER_ATTACK_POWER = 206
        let TOWER_DEFENCE_POWER = 207
        let TOWER_MIND_POWER = 208
        let TOWER_LUCKY_POWER = 209
        let TOWER_SPEED_POWER = 210
        let _towerEnum = [TOWER_MIND_POWER, TOWER_FIRE_ENERGE, TOWER_LUCKY_POWER, TOWER_SPEED_POWER, TOWER_TIME_REDUCE, TOWER_ATTACK_POWER, TOWER_DEFENCE_POWER, TOWER_WATER_ENERGE, TOWER_MAGICAL_POWER, TOWER_PHYSICAL_POWER, TOWER_THUNDER_ENERGE]
        switch _towerEnum.one() {
        case TOWER_MIND_POWER:
            return MindPowerTower()
        case TOWER_FIRE_ENERGE:
            return FireEnergeTower()
        case TOWER_LUCKY_POWER:
            return LuckyPowerTower()
        case TOWER_TIME_REDUCE:
            return TimeReduceTower()
        case TOWER_ATTACK_POWER:
            return AttackPowerTower()
        case TOWER_WATER_ENERGE:
            return WaterEnergeTower()
        case TOWER_DEFENCE_POWER:
            return DefencePowerTower()
        case TOWER_MAGICAL_POWER:
            return MagicalPowerTower()
        case TOWER_PHYSICAL_POWER:
            return PhysicalPowerTower()
        case TOWER_THUNDER_ENERGE:
            return ThunderEnergeTower()
        default:
            return FireEnergeTower()
        }
    }
    
    internal func findVisiblePoints() {
        var points = Array<CGPoint>()
        for y in 0..._ySize {
            for x in 0..._xSize {
                let cell = _mapMatrix[y][x]
                if cell == Cell.empty {
                    if y == _ySize{
                        points.append(CGPoint(x: x, y: y))
                    } else if y < _ySize {
                        if _mapMatrix[y + 1][x] == Cell.empty {
                            points.append(CGPoint(x: x, y: y))
                        }
                    }
                } else {
                    _wallPoints.append(CGPoint(x: x, y: y))
                }
            }
        }
        _visiblePoints = points
    }
    internal func createEnemy() {
        for _ in 0..._enemyCount {
            let point = _visiblePoints.one()
            let x = point.x.toInt()
            let y = point.y.toInt()
            if _mapMatrix[y][x] == Cell.empty {
                _mapMatrix[y][x] = Cell.enemy
                addCell(x: x, y: y, item: getEnemyNode(), z:ZIndex.enemy)
            }
        }
    }
    internal func createPortals() {
        let fromIndex = seed(max: _visiblePoints.count - 1)
        _portalPrev = _visiblePoints[fromIndex]
        let toIndex = seed(max: _visiblePoints.count - 1)
        _portalNext = _visiblePoints[toIndex]
        if fromIndex == toIndex {
            createPortals()
            return
        }
        let maxx = _xSize.toFloat()
        let maxy = (_ySize - 1).toFloat()
        var connected = false
        var checkedPoints = Array<CGPoint>()
        func isPointPortal(_ x:CGFloat, _ y:CGFloat) {
            var points = Array<CGPoint>()
            if x > 0 {
                let cell = _mapMatrix[y.toInt()][x.toInt() - 1]
                if cell == Cell.empty || cell == Cell.portal {
                    points.append(CGPoint(x: x - 1, y: y))
                }
            }
            if x < maxx {
                let cell = _mapMatrix[y.toInt()][x.toInt() + 1]
                if cell == Cell.empty || cell == Cell.portal {
                    points.append(CGPoint(x: x + 1, y: y))
                }
            }
            if y > 0 {
                let cell = _mapMatrix[y.toInt() - 1][x.toInt()]
                if cell == Cell.empty || cell == Cell.portal {
                    points.append(CGPoint(x: x, y: y - 1))
                }
            }
            if y < maxy {
                let cell = _mapMatrix[y.toInt() + 1][x.toInt()]
                if cell == Cell.empty || cell == Cell.portal {
                    points.append(CGPoint(x: x, y: y + 1))
                }
            }
            for p in points {
                if checkedPoints.firstIndex(of: p) == nil {
                    if p.x == _portalNext.x && p.y == _portalNext.y {
                        connected = true
                    } else {
                        checkedPoints.append(p)
                        if !connected {
                            isPointPortal(p.x, p.y)
                        }
                    }
                }
            }
        }
        
        isPointPortal(_portalPrev.x, _portalPrev.y)
        
        if !connected {
            createPortals()
            return
        }
        if fromIndex > toIndex {
            _visiblePoints.remove(at: fromIndex)
            _visiblePoints.remove(at: toIndex)
        } else {
            _visiblePoints.remove(at: toIndex)
            _visiblePoints.remove(at: fromIndex)
        }
        _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = Cell.empty
        _mapMatrix[_portalPrev.y.toInt()][_portalPrev.x.toInt()] = Cell.empty
        addPortalnode()
    }
    internal func addPortalnode() {
        let texture = SKTexture(imageNamed: "tilesets")
        let next = texture.getNode(5, 2)
        next.zPosition = ZIndex.portal
        let prev = texture.getNode(6, 2)
        prev.zPosition = ZIndex.portal
        addCell(x: _portalNext.x.toInt(), y: _portalNext.y.toInt(), item: next)
        addCell(x: _portalPrev.x.toInt(), y: _portalPrev.y.toInt(), item: prev)
    }
    internal func getEnemyNode() -> EnemyNode {
        let node = EnemyNode()
        let data = Minions.data[_enemyType.one()]!
        node.setRole(node: SKTexture(imageNamed: data.imgUrl).getNode(0, seed(max: 3).toFloat()))
        return node
    }
    //    internal func getCellItem() -> SKSpriteNode {
    //        return SKTexture(imageNamed: "Outside_B").getNode(5, 11, 1, 2)
    //    }
    internal var _enemyCount = 10
    internal var _visiblePoints = Array<CGPoint>()
    internal var _wallPoints = Array<CGPoint>()
    internal var _enemyType:Array<String> = []
    var _herbs = [Item.Caesalpinia, Item.Curium, Item.DragonRoot, Item.SkyAroma, Item.PanGrass]
}
