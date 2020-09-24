//
//  Castable.swift
//  MyTravel
//
//  Created by kai chen on 2020/9/14.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
protocol Castable {
    var castSelf:Bool { get }
    var autoCast:Bool { get }
    func cast(completion:@escaping () -> Void)
}
