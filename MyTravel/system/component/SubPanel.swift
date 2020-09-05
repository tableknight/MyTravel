//
//  SubPanel.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/5.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class SubPanel: Panel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = ZIndex.sub_panel
        let size = Device.getDeviceSize()
        let mask = createBackground(width: size.width, height: size.height)
        mask.lineWidth = 0
        mask.alpha = 0.75
        addChild(mask)
        _panelHeight = (Size.default_cell_y_count + 1).toFloat() * cellSize
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
