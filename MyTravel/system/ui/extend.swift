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
    func clone() -> Array<Any> {
        var c = Array<Any>()
        for n in self {
            c.append(n)
        }
        return c
    }
    
}
extension SKTexture {
    func getCell(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKTexture {
//        let revealCellSize:CGFloat = 36
        let textureCellSize:CGFloat = 48
        let textureWidth = size().width
        let textureHeight = size().height
        
        let startY = textureHeight / textureCellSize - (y + hSize)
        let width = textureCellSize / textureWidth
        let height = textureCellSize / textureHeight
        
        let rect = CGRect(x: x * width, y: startY * height, width: width * wSize, height: height * hSize)
        let texture = SKTexture(rect: rect, in: self)
        return texture
        /*
         ect: let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
         */
//        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
//        node.size = CGSize(width: revealCellSize * wSize, height: revealCellSize * hSize)
//        return node
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
    var y:CGFloat {
        set {
            position.y = newValue
        }
        get {
            return position.y
        }
    }
    var x:CGFloat {
        set {
            position.x = newValue
        }
        get {
            return position.x
        }
    }
    var cellSize:CGFloat {
        get {
            return 36
        }
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        var max = max
        if max != 101 {
            max = max + 1
        }
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    func toTexture() -> SKTexture {
        let view = SKView()
        return view.texture(from: self)!
    }
    func createBackground(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = Value.border_radius) -> SKShapeNode {
    //    let b = CGRect(x: -width * 0.5, y: -height * 0.5, width: width, height: height)
    //    let bg = SKShapeNode(rect: b, cornerRadius: cornerRadius)
        let bg = SKShapeNode(rectOf: CGSize(width: width, height: height), cornerRadius: cornerRadius)
        bg.fillColor = UIColor.black
        bg.strokeColor = Value.unselected_stroke_color
        bg.lineWidth = Value.unselected_stroke_width
        bg.alpha = Value.background_alpha
        bg.position.x = 0
        bg.position.y = 0
    //    bg.zPosition = zPos
        return bg
    }
}
