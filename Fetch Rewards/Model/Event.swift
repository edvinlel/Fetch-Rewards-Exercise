//
//  Event.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/30/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import Foundation

struct Event: Codable {
    var announceDate: String
//    var datetime_local: String
//    var venue: Venue
//    var url: String
//    var title: String
    
    enum CodingKeys: String, CodingKey {
        case announceDate
    }
}
