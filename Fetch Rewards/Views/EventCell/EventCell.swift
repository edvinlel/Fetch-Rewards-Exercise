//
//  EventCell.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/19/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

protocol EventCellDelegate: class {
    func eventCell(_ cell: UITableViewCell, button: UIButton)
}

class EventCell: UITableViewCell {
    
    static let reuseIdentifier = "EventCell"
    weak var delegate: EventCellDelegate?
    
    // MARK: Properties
    let mainBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let eventBackgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let alphaLayer: AlphaLayerView = {
        let view = AlphaLayerView()
        return view
    }()
    
    let dateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Dec"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.font = UIFont(name: "AvenirNext-Heavy", size: 30)
        label.textColor = .red
        return label
    }()
    
    let performerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 35)
        label.text = "Snoop Dogg"
        label.textColor = .white
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.text = "Sippin on Gin N Juice Tour"
        label.textColor = .white
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    
    let eventLocation: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.text = "Modesto, CA"
        label.textColor = UIColor.FetchRewardsColor.background
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "like"), for: .normal)
        
        return button
    }()

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.FetchRewardsColor.background
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none

        
        setSubviewForAutoLayout(mainBackground)
        
        mainBackground.setSubviewsForAutoLayout([
            eventBackgroundImageView,
            eventImageView,
            alphaLayer,
            dateContainerView,
            titleLabel,
            performerLabel,
            eventLocation,
            likeButton
        ])
        
        dateContainerView.setSubviewsForAutoLayout([
            dayLabel,
            monthLabel
        ])
        
        setConstraints()
        
        
        bringSubviewToFront(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
        
    }
    
    // MARK: Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        delegate?.eventCell(self, button: sender)
    }
    
    // MARK: Helper Methods
    func setCell(event: Event) {
        titleLabel.text = event.title
        performerLabel.text = event.performers[0].name
        eventLocation.text = event.venue.displayLocation
        eventImageView.kf.setImage(with: URL(string: event.performers[0].image))
        FirebaseLayer.isEventLiked(event: event) { (isLiked) in
            if isLiked {
                self.likeButton.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            } else {
                self.likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }
        }
        guard let date = Event.convert(date: event.datetimeLocal) else { return }
        dayLabel.text = "\(date.day)"
        monthLabel.text = Event.month(by: date.month)
    }
    
    // MARK: Constraints
    private func setConstraints() {
        /// Container View
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            mainBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            mainBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            eventBackgroundImageView.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: 0),
            eventBackgroundImageView.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: 0),
            eventBackgroundImageView.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: 0),
            eventBackgroundImageView.bottomAnchor.constraint(equalTo: mainBackground.bottomAnchor, constant: 0)
        ])
        
        /// Event ImageView
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: eventBackgroundImageView.topAnchor, constant: 0),
            eventImageView.rightAnchor.constraint(equalTo: eventBackgroundImageView.rightAnchor, constant: 0),
            eventImageView.leftAnchor.constraint(equalTo: eventBackgroundImageView.leftAnchor, constant: 0),
            eventImageView.bottomAnchor.constraint(equalTo: eventBackgroundImageView.bottomAnchor, constant: 0)
        ])
        
        /// Alpha Layer
        NSLayoutConstraint.activate([
            alphaLayer.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 0),
            alphaLayer.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 0),
            alphaLayer.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 0),
            alphaLayer.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 0)
        ])
        
        /// Date ContainerView
        NSLayoutConstraint.activate([
            dateContainerView.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 10),
            dateContainerView.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -10),
            dateContainerView.widthAnchor.constraint(equalToConstant: 65),
            dateContainerView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        /// Date Label
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: dateContainerView.centerXAnchor, constant: 0),
            dayLabel.centerYAnchor.constraint(equalTo: dateContainerView.centerYAnchor, constant: -5)
        ])
        
        /// Month Label
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: dateContainerView.centerXAnchor, constant: 0),
            monthLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: -5)
        ])
        
        /// Event Title
        NSLayoutConstraint.activate([
            performerLabel.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: -40),
            performerLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 10),
            performerLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -10)
        ])
        
        /// Title Label
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: performerLabel.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -10)
        ])
        
        
        /// Event Location
        NSLayoutConstraint.activate([
            eventLocation.bottomAnchor.constraint(equalTo: performerLabel.bottomAnchor, constant: 25),
            eventLocation.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 10),
            eventLocation.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -10)
        ])
        
        
        
        /// Like ImageView
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: dateContainerView.centerYAnchor, constant: 0),
            likeButton.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 10),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
