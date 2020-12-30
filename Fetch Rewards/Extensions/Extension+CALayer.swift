//
//  Extension+CALayer.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/20/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

/// Extension I found on GitHub. https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur
/// that allows you to use the shadow designed on the software Sketch and turn it in for ios design.

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
