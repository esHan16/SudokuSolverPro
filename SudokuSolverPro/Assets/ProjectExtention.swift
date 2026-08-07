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
    
    static func timerColor() -> UIColor {
        UIColor(red: 65, green: 71, blue: 85)
    }
    
    static func enteredTextColor() -> UIColor {
        UIColor(red: 47, green: 158, blue: 68)
    }
    
    static func localeColor() -> UIColor {
        UIColor(red: 65, green: 71, blue: 85)
    }
    
    static func borderColor() -> UIColor {
        UIColor(red: 226, green: 226, blue: 226)
    }
    
    static func homeBGColor() -> UIColor {
        UIColor(red: 238, green: 238, blue: 238)
    }
    
}

extension UIFont {

    static func light(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .light)
    }

    static func regular(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }

    static func medium(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .medium)
    }

    static func semibold(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .semibold)
    }

    static func bold(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .bold)
    }

    static func heavy(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .heavy)
    }

    static func black(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .black)
    }
}

extension UIViewController {
    
    func showToast(message: String) {
        // 1. Create the main container view
        let toastView = UIView()
        toastView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        
        // Add the thin red border seen in the image
        toastView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.6).cgColor
        toastView.layer.borderWidth = 1.0
        
        // Make it a pill shape (adjust this based on your font size/padding)
        toastView.layer.cornerRadius = 24
        toastView.clipsToBounds = true
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        // Optional: Add a subtle shadow for depth
        toastView.layer.shadowColor = UIColor.black.cgColor
        toastView.layer.shadowOpacity = 0.1
        toastView.layer.shadowOffset = CGSize(width: 0, height: 2)
        toastView.layer.shadowRadius = 4
        toastView.layer.masksToBounds = false
        
        // 2. Create the Error Icon
        let iconImageView = UIImageView()
        // Using SF Symbols for the exclamation mark
        iconImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        iconImageView.tintColor = .systemRed
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 3. Create the Message Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. Setup the StackView to hold the icon and text
        let stackView = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        toastView.addSubview(stackView)
        self.view.addSubview(toastView)
        
        // 5. Apply Auto Layout Constraints
        NSLayoutConstraint.activate([
            // Fix icon size
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            // Constrain stack view inside the toast view with padding
            stackView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10),
            
            // Constrain toast view to the center of the screen (or top/bottom if preferred)
            toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toastView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), // Adjust to topAnchor if you want it at the top
            
            // Ensure it doesn't bleed off small screens
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20)
        ])
        
        // 6. Animate the Toast
        toastView.alpha = 0.0
        
        // Fade in over 0.3 seconds
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { _ in
            // Wait 2 seconds, then fade out over 0.3 seconds
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }) { _ in
                // Remove from view hierarchy once invisible
                toastView.removeFromSuperview()
            }
        }
    }
}
