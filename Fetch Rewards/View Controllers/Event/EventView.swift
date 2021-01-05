//
//  EventView.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/30/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

class EventView: UIView {
    // MARK: Properties
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snoop")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let alphaLayer: AlphaLayerView = {
        let view = AlphaLayerView()
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Dec 20, 2021"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "7:30 PM"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Sippin on Gin N Juice Tour"
        label.font = UIFont(name: "AvenirNext-Heavy", size: 40)
        label.numberOfLines = 0
        return label
    }()
    
    let performerLabel: UILabel = {
        let label = UILabel()
        // TODO: Put this color variable to store in fetch rewards color
        label.textColor = UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1)
        label.text = "Snoop Dogg"
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "date")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "like"), for: .normal)
        return button
    }()
    
    let buyTicketsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "buyTickets"), for: .normal)
        return button
    }()
    
    let venueNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Spanos Center"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let venueAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "301 Pacific Ave, Stockton, CA"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "share"), for: .normal)
        return button
    }()
    
    let dateSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let mapSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.FetchRewardsColor.background
        
        setSubviewsForAutoLayout([
            backgroundImageView,
            alphaLayer,
            backButton,
            dateLabel,
            timeLabel,
            titleLabel,
            performerLabel,
            likeButton,
            shareButton,
            buyTicketsButton,
            dateImageView,
            mapImageView,
            dateSeparator,
            mapSeparator,
            venueNameLabel,
            venueAddressLabel
            
        ])
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEvent(event: Event) {
        titleLabel.text = event.title
        performerLabel.text = event.performers[0].name
        backgroundImageView.kf.setImage(with: URL(string: event.performers[0].image))
        dateLabel.text = event.datetimeLocal
        venueNameLabel.text = event.venue.name
        venueAddressLabel.text = "\(event.venue.address) \(event.venue.displayLocation)"
        FirebaseLayer.isEventLiked(event: event) { (isLiked) in
            if isLiked {
                self.likeButton.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            } else {
                self.likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }
        }
        guard let date = Event.convert(date: event.datetimeLocal) else { return }
        dateLabel.text = "\(Event.month(by: date.month)) \(date.day), \(date.year)"
    }
    
    // MARK: Constraints
    private func setConstraints() {
        /// Background ImageView
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        /// Alpha Layer
        NSLayoutConstraint.activate([
            alphaLayer.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0),
            alphaLayer.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 0),
            alphaLayer.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: 0),
            alphaLayer.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0)
        ])
        
        
        /// Back Button
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        
        
        
        
        /// Performer Label
        NSLayoutConstraint.activate([
            performerLabel.bottomAnchor.constraint(equalTo: dateImageView.topAnchor, constant: -60),
            performerLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 20),
            performerLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -20)
        ])
        
        /// Title Label
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: performerLabel.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: 60)
        ])
        
        /// Like Button
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -5),
            likeButton.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -15),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        /// Date ImageView
        NSLayoutConstraint.activate([
            dateImageView.bottomAnchor.constraint(equalTo: mapImageView.topAnchor, constant: -40),
            dateImageView.leftAnchor.constraint(equalTo: performerLabel.leftAnchor, constant: 0),
            dateImageView.widthAnchor.constraint(equalToConstant: 72),
            dateImageView.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        /// Date Separator
        NSLayoutConstraint.activate([
            dateSeparator.leftAnchor.constraint(equalTo: dateImageView.rightAnchor, constant: 20),
            dateSeparator.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor, constant: 0),
            dateSeparator.widthAnchor.constraint(equalToConstant: 1),
            dateSeparator.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        /// Date Label
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dateSeparator.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: dateSeparator.rightAnchor, constant: 20),
            dateLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -20)
        ])
        
        /// Time Label
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            timeLabel.leftAnchor.constraint(equalTo: dateSeparator.rightAnchor, constant: 20),
            timeLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -20)
        ])
        
        /// Map ImageView
        NSLayoutConstraint.activate([
            mapImageView.bottomAnchor.constraint(equalTo: buyTicketsButton.topAnchor, constant: -40),
            mapImageView.leftAnchor.constraint(equalTo: performerLabel.leftAnchor, constant: 0),
            mapImageView.widthAnchor.constraint(equalToConstant: 72),
            mapImageView.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        NSLayoutConstraint.activate([
            mapSeparator.leftAnchor.constraint(equalTo: mapImageView.rightAnchor, constant: 20),
            mapSeparator.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor, constant: 0),
            mapSeparator.widthAnchor.constraint(equalToConstant: 1),
            mapSeparator.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        /// Venue Name Label
        NSLayoutConstraint.activate([
            venueNameLabel.topAnchor.constraint(equalTo: mapSeparator.topAnchor, constant: 20),
            venueNameLabel.leftAnchor.constraint(equalTo: mapSeparator.rightAnchor, constant: 20),
            venueNameLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -20)
        ])
        
        /// Venue Address Label
        NSLayoutConstraint.activate([
            venueAddressLabel.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 5),
            venueAddressLabel.leftAnchor.constraint(equalTo: mapSeparator.rightAnchor, constant: 20),
            venueAddressLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -20)
        ])
        
        
        /// Buy Tickets Button
        NSLayoutConstraint.activate([
            buyTicketsButton.widthAnchor.constraint(equalToConstant: 180),
            buyTicketsButton.heightAnchor.constraint(equalToConstant: 60),
            buyTicketsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            buyTicketsButton.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -15)
            buyTicketsButton.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: 0)
        ])
        
        /// Share Button
        NSLayoutConstraint.activate([
//            shareButton.centerYAnchor.constraint(equalTo: buyTicketsButton.centerYAnchor, constant: 0),
//            shareButton.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 45)
            shareButton.topAnchor.constraint(equalTo: likeButton.topAnchor, constant: -8),
            shareButton.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -25)
        ])
    }
}
