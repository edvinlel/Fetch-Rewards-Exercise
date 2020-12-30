//
//  EventCell.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/19/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    // MARK: ReuseIdentifier
    static let reuseIdentifier = "EventCell"
    
    // MARK: Properties
    let shadowLayer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.9
        view.layer.shadowRadius = 5
        return view
    }()
    
    let mainBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
//        view.layer.
        return view
    }()
    
    let eventBackgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let informationContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.FetchRewardsColor.background

        selectionStyle = .none
        
        setSubviewForAutoLayout(shadowLayer)
        shadowLayer.setSubviewsForAutoLayout([mainBackground, eventImageView, informationContainerView])
        
        setConstraints()
        
//        containerView.layer.applySketchShadow(color: .blue, alpha: 0.5, x: 10, y: 0, blur: 4, spread: 80)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints
    private func setConstraints() {
        /// Shadow Layer
        NSLayoutConstraint.activate([
            shadowLayer.topAnchor.constraint(equalTo: topAnchor, constant: 45),
            shadowLayer.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            shadowLayer.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            shadowLayer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        /// Container View
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: shadowLayer.topAnchor, constant: 0),
            mainBackground.leftAnchor.constraint(equalTo: shadowLayer.leftAnchor, constant: 0),
            mainBackground.rightAnchor.constraint(equalTo: shadowLayer.rightAnchor, constant: 0),
            mainBackground.bottomAnchor.constraint(equalTo: shadowLayer.bottomAnchor, constant: 0)
        ])
        
        /// Event ImageView
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: 0),
            eventImageView.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: 0),
            eventImageView.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: 0),
            eventImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        // Information ContainerView
        NSLayoutConstraint.activate([
            informationContainerView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 0),
            informationContainerView.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: 0),
            informationContainerView.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: 0),
            informationContainerView.bottomAnchor.constraint(equalTo: mainBackground.bottomAnchor, constant: 0)
        ])
    }
    
}
