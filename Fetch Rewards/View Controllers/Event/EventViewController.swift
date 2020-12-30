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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = EventView()
    }
    


}
