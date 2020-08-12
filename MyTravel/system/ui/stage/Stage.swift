//
//  Stage.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Stage: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func loadScene(scene:Scene) {
        addChild(scene)
    }
    func setRole(role:ActionUnit) {
//        role.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(role)
    }
}
