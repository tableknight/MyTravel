//
//  extend.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
extension CGFloat {
    func toInt() -> Int {
        return Int(self)
    }
}
extension Int {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Array {
    func one() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}
extension SKTexture {
    func getCell(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKTexture {
//        let cellSize = Game.instance.cellSize
        let realSize:CGFloat = 48
        var cellSize:CGFloat = 48
        if realSize != cellSize {
            let tnode = SKSpriteNode(texture: self)
            let xw = tnode.size.width.toInt() % realSize.toInt()
            if xw == 0 {
                cellSize = realSize
            }
        }
//        if self.size().width % 64 == 0 {
//
//        }
        let w = size().width
        let h = size().height
        let _y = h / cellSize - y - 1
        let width = cellSize / w
        let height = cellSize / h
        
        let rect = CGRect(x: x * width, y: _y * height, width: width * wSize, height: height * hSize)
//        print(rect)
//        let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
        node.size = CGSize(width: realSize * wSize, height: realSize * hSize)
//        node.size.width = cellSize * 1.5
//        node.size.height = cellSize * 1.5
        let view = SKView()
        return view.texture(from: node)!
    }
    func getNode(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKSpriteNode {
        let revealCellSize:CGFloat = 36
        let textureCellSize:CGFloat = 48
        let textureWidth = size().width
        let textureHeight = size().height
        
//        if revealCellSize != textureCellSize {
//            let tnode = SKSpriteNode(texture: self)
//            let xw = tnode.size.width.toInt() % revealCellSize.toInt()
//            if xw == 0 {
//                textureCellSize = revealCellSize
//            }
//        }
        
        let startY = textureHeight / textureCellSize - (y + hSize)
        let width = textureCellSize / textureWidth
        let height = textureCellSize / textureHeight
        
        let rect = CGRect(x: x * width, y: startY * height, width: width * wSize, height: height * hSize)
        /*
         ect: let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
         */
        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
        node.size = CGSize(width: revealCellSize * wSize, height: revealCellSize * hSize)
        return node
    }
}
extension SKNode {
    var cellSize:CGFloat {
        get {
            return 36
        }
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
}
