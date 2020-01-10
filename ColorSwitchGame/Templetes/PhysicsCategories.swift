//
//  Settings.swift
//  ColorSwitchGame
//
//  Created by Julio Collado on 1/10/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    
    case none, ballCategory, switchCategory
    
    var category: UInt32 {
        switch self {
        case .none:
            return 0
        case .ballCategory:
            return 0x1           // 01
        case .switchCategory:
            return 0x1 << 1     // 10
        }
    }
    
}
