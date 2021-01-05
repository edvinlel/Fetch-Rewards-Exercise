//
//  APIResult.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 1/2/21.
//  Copyright © 2021 Edvin Lellhame. All rights reserved.
//

import Foundation

struct APIResult: Codable {
    let events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events
    }
}

struct Event: Codable {
    let id: Int
    let venue: Venue
    let datetimeUTC: String
    let performers: [Performer]
    let eventDescription: String
    let datetimeLocal: String
    let url: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case venue
        case datetimeUTC = "datetime_utc"
        case performers
        case eventDescription = "description"
        case datetimeLocal = "datetime_local"
        case url, title
    }
    
    static func month(by number: Int) -> String {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return months[number - 1]
    }
    
//    static func month(by number: Int) -> String {
//        switch number {
//        case 1: return "Jan"
//        case 2: return "Feb"
//        case 3: return "Mar"
//        case 4: return "Apr"
//        case 5: return "May"
//        case 6: return "Jun"
//        case 7: return "Jul"
//        case 8: return "Aug"
//        case 9: return "Sep"
//        case 10: return "Oct"
//        case 11: return "Nov"
//        case 12: return "Dec"
//        default:
//            return ""
//        }
//    }
    static func convert(date: String) -> (month: Int, day: Int, year: Int)? {
        var month = 0
        var day = 0
        var year = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let returnedDate = dateFormatter.date(from: date) {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: returnedDate)
            month = dateComponents.month!
            day = dateComponents.day!
            year = dateComponents.year!
        } else {
           return nil
        }
        return(month, day, year)
    }
}

struct Venue: Codable {
    let address: String
    let displayLocation: String
    let name: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case address, name
        case displayLocation = "display_location"
        case location
    }
}

struct Location: Codable {
    let lat, lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}

struct Performer: Codable {
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name, image
    }
}
