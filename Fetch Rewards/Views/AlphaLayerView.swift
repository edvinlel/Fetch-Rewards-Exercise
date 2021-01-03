//
//  AlphaLayerView.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 1/1/21.
//  Copyright © 2021 Edvin Lellhame. All rights reserved.
//

import UIKit

class AlphaLayerView: UIView {

    let alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setSubviewForAutoLayout(alphaView)
        
        NSLayoutConstraint.activate([
            alphaView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            alphaView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            alphaView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            alphaView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

}
