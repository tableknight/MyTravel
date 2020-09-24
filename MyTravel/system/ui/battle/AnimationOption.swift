//
//  AnimationOption.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/16.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class AnimationOption {
    init() {
        
    }
    var imgUrl:String = ""
    var frameSize:Int = 0
    var pictureWidth:CGFloat = 960
    var pictureheight:CGFloat = 1200
    var startX:CGFloat = 0
    var startY:CGFloat = 0
    var selfLayer:Bool = true
    var executeTimes:Int = 1
    var fadeOut = false
    var duration:CGFloat = 83
    var toAppendActions = Array<SKAction>()
    var single = false
    var targetLayer:SKSpriteNode!
    var repeatForever = false
    var yAxis:CGFloat = 0
    var layerSize:CGFloat = 2
    var lasting:CGFloat = 0
}
