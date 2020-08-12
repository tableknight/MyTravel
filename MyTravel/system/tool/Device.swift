//
//  Device.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class Device {
    static func getDeviceSize() -> CGSize {
        let bounds = UIScreen.main.bounds.size
        return bounds
    }
}
