//
//  Extension+UIView.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/18/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

extension UIView {
    internal func setSubviewForAutoLayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    internal func setSubviewsForAutoLayout(_ subviews: [UIView]) {
        _ = subviews.map { self.setSubviewForAutoLayout($0) }
    }
    
    internal func set(cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
