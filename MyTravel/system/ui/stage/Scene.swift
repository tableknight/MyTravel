//
//  Scene.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Scene: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addChild(_cellLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create() {
        createGround()
        createMatrix()
    }
    internal func createGround() {
        let gs = GroundSet(groundSet: _groundNode)
        addCell(x: 0, y: 0, item: gs.getTopLeftCorner())
        addCell(x: _xSize, y: 0, item: gs.getTopRightCorner())
        addCell(x: 0, y: _ySize + 2, item: gs.getBottomLeft())
        addCell(x: _xSize, y: _ySize + 2, item: gs.getBottomRight())
        for y0 in 1..._ySize - 1 {
            addCell(x: 0, y: y0, item: gs.getLeftBound())
            addCell(x: _xSize, y: y0, item: gs.getRightBound())
        }
        for x in 1..._xSize - 1 {
            addCell(x: x, y: 0, item: gs.getTopConnector())
            addCell(x: x, y: _ySize + 2, item: gs.getBottomConnector())
            for y in 1..._ySize - 1 {
                addCell(x: x, y: y, item: gs.getMiddleGround())
            }
        }
        let groundNode = SKSpriteNode(texture: _cellLayer.toTexture())
        groundNode.zPosition = ZIndex.ground
        groundNode.position.y = -cellSize
        addChild(groundNode)
        _cellLayer.removeAllChildren()
    }
    
    func getCellType(x: Int, y: Int) -> Int {
        return _mapMatrix[y][x]
    }
    
    internal func createMatrix() {
        
    }
    
    func addCell(x:Int, y:Int, item:CellNode, z:CGFloat = 0) {
        //        let yAnchor = cellSize / item.size.height
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-_xSize / 2 + x).toFloat() * cellSize
        item.position.y = (_ySize / 2 - y).toFloat() * cellSize
        if z > 0 {
            item.zPosition = z
        }
        item.name = "cell\(y)\(x)"
        _cellLayer.addChild(item)
    }
    func addCell(x:Int, y:Int, item:SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-_xSize / 2 + x).toFloat() * cellSize
        item.position.y = (_ySize / 2 - y).toFloat() * cellSize
        _cellLayer.addChild(item)
    }
    
    func getCellNode(x:Int, y:Int) -> CellNode {
        return childNode(withName: "item\(y)\(x)") as! CellNode
    }
    
    //    func addBoundCells() {
    //        addCell(x: 0, y: 0, item: getBoundCell())
    //        addCell(x: _xSize, y: 0, item: getBoundCell())
    //        addCell(x: 0, y: _ySize, item: getBoundCell())
    //        addCell(x: _xSize, y: _ySize, item: getBoundCell())
    //    }
    //    private func getBoundCell() -> SKSpriteNode{
    //        //        let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize))
    //        //        shape.fillColor = UIColor.white
    //        let node = SKSpriteNode()
    //        //        node.addChild(shape)
    //        node.color = UIColor.white
    //        node.size = CGSize(width: cellSize, height: cellSize)
    //        return node
    //    }
    
    internal var _xSize = Size.default_cell_x_count
    internal var _ySize = Size.default_cell_y_count
    internal var _cellLayer = SKSpriteNode()
    internal var _groundNode:SKSpriteNode!
    internal var _mapMatrix:Array<Array<Int>> = []
    internal var _portalPrev:CGPoint!
    internal var _portalNext:CGPoint!
    internal var _id = -1
    var _name = ""
    var _soundUrl = ""
}
