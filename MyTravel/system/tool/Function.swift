//
//  Alert.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/18.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
func showMsg(text:String) {
//    let cellSize = Game.instance.cellSize
//    let fontSize = cellSize * 0.5
//    let node = SKSpriteNode()
//    let width = (text.count * fontSize.toInt() + 100).toFloat()
//    let rect = CGRect(x: -width * 0.5, y: -cellSize, width: width, height: cellSize * 2)
//    let bg = SKShapeNode(rect: rect, cornerRadius: 4)
//    bg.fillColor = UIColor.black
//    bg.alpha = 0.65
//    node.addChild(bg)
//    
//    let border = SKShapeNode(rect: rect, cornerRadius: 4)
//    border.lineWidth = 2
//    node.addChild(border)
//    
//    let l = Label()
//    l.fontSize = fontSize
//    l.align = "center"
//    l.text = text
//    l.position.y = 12
//    node.addChild(l)
//    
//    node.zPosition = 1200
//    let stage = Game.curStage!
//    stage._messageNode.removeFromParent()
//    stage._messageNode = node
////    node.isUserInteractionEnabled = true
//    stage.addChild(node)
//    setTimeout(delay: 3, completion: {
//        if stage.contains(node) {
//            node.removeFromParent()
//            stage._messageNode = SKSpriteNode()
//        }
//    })
}
func setTimeout(delay:CGFloat, completion: @escaping () -> Void) {
    if delay <= 0 {
        completion()
        return
    }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(delay), execute: {
        completion()
    })
}
