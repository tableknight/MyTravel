//
//  GroundSet.swift
//  MyTravel
//
//  Created by kai chen on 2020/8/12.
//  Copyright © 2020 my.travel. All rights reserved.
//

import SpriteKit
class GroundSet {
    private var _groundSet:SKTexture!
    init(groundSet:SKSpriteNode) {
        groundSet.size = CGSize(width: Size.texture_cell_size * 2, height: Size.texture_cell_size * 4)
        _groundSet = groundSet.toTexture()
    }
    func getTopLeftCorner() -> SKSpriteNode {
        return _groundSet.getNode(0, 0)
    }
    func getTopConnector() -> SKSpriteNode {
        return _groundSet.getNode(0.5, 0)
    }
    func getTopRightCorner() -> SKSpriteNode {
        return _groundSet.getNode(1, 0)
    }
    func getBottomLeft() -> SKSpriteNode{
        return _groundSet.getNode(0, 1, 1, 3)
    }
    func getBottomRight() -> SKSpriteNode{
        return _groundSet.getNode(1, 1, 1, 3)
    }
    func getBottomConnector() -> SKSpriteNode {
        return _groundSet.getNode(0.55, 1, 1, 3)
    }
    func getLeftBound() -> SKSpriteNode {
        return _groundSet.getNode(0, 0.5)
    }
    func getMiddleGround() -> SKSpriteNode {
        return _groundSet.getNode(0.5, 0.5)
    }
    func getRightBound() -> SKSpriteNode {
        return _groundSet.getNode(1, 0.5)
    }
}
