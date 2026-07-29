//
//  ProjectExtention.swift
//  SudokuSolverPro
//
//  Created by Eshan on 28/07/26.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    static func outerBoundary() -> UIColor {
//        UIColor(red: 49, green: 44, blue: 133)
        textColor()
    }

    static func innerBoundary() -> UIColor {
        // UIColor(red: 199, green: 210, blue: 255)
        UIColor(red: 194, green: 198, blue: 214)
    }

    static func selectedBackground() -> UIColor {
        UIColor(red: 238, green: 242, blue: 255)
    }
    
    static func selectedBackground2() -> UIColor {
        UIColor(red: 224, green: 231, blue: 255)
    }
    
    static func errorTap() -> UIColor {
        UIColor(red: 255, green: 238, blue: 238)
    }
    
    static func textColor() -> UIColor {
        UIColor(red: 26, green: 28, blue: 28)
    }
    
    static func selectedKeyColor() -> UIColor {
        UIColor(red: 0, green: 88, blue: 188)
    }
    
    static func defaultKeyColor() -> UIColor {
        UIColor(red: 238, green: 238, blue: 238)
    }
    
}
