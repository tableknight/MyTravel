//
//  Test.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit

func getCross() -> SKSpriteNode {
    let node = SKSpriteNode()
    let device = Device.getDeviceSize()
    let xline = SKShapeNode(rect: CGRect(x: -device.width / 2, y: 0, width: device.width, height: 1))
//    xline.size = CGSize(width: device.width, height: 1)
    xline.fillColor = UIColor.white
    xline.lineWidth = 0
    node.addChild(xline)
    let yline = SKShapeNode(rect: CGRect(x: 0, y: -device.height / 2, width: 1, height: device.height))
    //    xline.size = CGSize(width: device.width, height: 1)
        yline.fillColor = UIColor.white
        yline.lineWidth = 0
        node.addChild(yline)
//    node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    return node
}
