//
//  EventViewController.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/30/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit
import Kingfisher


class EventViewController: UIViewController {
    
    // MARK: Properties
    weak var eventView: EventView! { return self.view as? EventView }
    
    var event: Event!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = EventView()
        
        setTargets()
        
        eventView.setEvent(event: event)
    }
    
    
    
    
    // MARK: Helper Functions
    private func setTargets() {
        eventView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        eventView.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        eventView.buyTicketsButton.addTarget(self, action: #selector(buyTicketButtonPressed), for: .touchUpInside)
        eventView.venueNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(venueTapped)))
        eventView.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
    }
    
    @objc private func likeButtonPressed() {
        
        FirebaseLayer.isEventLiked(event: self.event) { (isLiked) in
            if isLiked {
                FirebaseLayer.remove(event: self.event) {
                    self.eventView.likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
                }
            } else {
                FirebaseLayer.add(event: self.event) {
                    self.eventView.likeButton.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                }
            }
        }
        
    }
    
    @objc private func venueTapped() {
        
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func buyTicketButtonPressed() {
        guard let url = URL(string: event.url) else { return }
        
        UIApplication.shared.open(url)
    }
    
    @objc private func shareButtonPressed() {
        let shareText = "Check this out!"
        
        guard let url = URL(string: event.performers[0].image) else { return }
        
        let downloader = ImageDownloader.default
        downloader.downloadImage(with: url, completionHandler:  { result in
            switch result {
            case .success(let value):
                let vc = UIActivityViewController(activityItems: [shareText, value.image], applicationActivities: [])
                self.present(vc, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    
}
