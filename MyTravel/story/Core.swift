//
//  Core.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Core:NSObject, Codable{
    override init() {
        super.init()
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
}


