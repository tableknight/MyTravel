//
//  Battle.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/4.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Battle: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = ZIndex.panel
        let size = Device.getDeviceSize()
        let mask = createBackground(width: size.width, height: size.height)
        mask.lineWidth = 0
        mask.alpha = 0.65
        addChild(mask)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func start() {
        Game.curStage.cancelTouch = true
        Game.curStage.hideUI()
        Game.curStage.addChild(self)
    }
    private func addPlayerUnits() {
        let c = Game.curChar!
        for s in c._selectedField._fieldSeats {
            if !s._uid.isEmpty {
                
            }
        }
    }
}
