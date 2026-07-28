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
        UIColor(red: 49, green: 44, blue: 133)
    }

    static func innerBoundary() -> UIColor {
        UIColor(red: 199, green: 210, blue: 255)
    }

    static func selectedBackground() -> UIColor {
        UIColor(red: 238, green: 242, blue: 255)
    }
    
    static func selectedBackground2() -> UIColor {
        UIColor(red: 224, green: 231, blue: 255)
    }
    
}
