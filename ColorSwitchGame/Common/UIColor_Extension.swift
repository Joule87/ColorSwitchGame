//
//  UIColor_Extension.swift
//  ColorSwitchGame
//
//  Created by Julio Collado on 1/10/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let appBackgroundColor = UIColor.rbg(r: 44, g: 62, b: 80)
    
    static func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}

