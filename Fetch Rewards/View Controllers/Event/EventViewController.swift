//
//  EventViewController.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/30/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit


class EventViewController: UIViewController {
    
    // MARK: Properties
    weak var eventView: EventView! { return self.view as? EventView }

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = EventView()
        
        setTargets()
    }
    
    // MARK: Helper Functions
    private func setTargets() {
        eventView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: false)
    }

}
