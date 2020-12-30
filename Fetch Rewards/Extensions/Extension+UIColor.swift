//
//  Extension+UIColor.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/20/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Helper method to eliminate the need to / 255.0 for the red, green and blue values. Alpha
    /// is set to 1.
    ///
    /// - Parameters:
    ///   - red: CGFloat value for the red hue.
    ///   - green: CGFloat value for the green hue.
    ///   - blue: CGFloat value for the blue hue.
    static private func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }

    /// Fetch Rewards Application Theme Colors
    struct FetchRewardsColor {
        /// Background color for every screen
        static var background: UIColor { return UIColor.rgb(red: 236, green: 236, blue: 239) }
        
    }
}
