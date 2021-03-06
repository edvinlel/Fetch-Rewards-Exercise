//
//  EventDataSource.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 1/4/21.
//  Copyright © 2021 Edvin Lellhame. All rights reserved.
//

import UIKit

class EventDataSource: NSObject, UITableViewDataSource, EventCellDelegate {
    weak var tableView: UITableView?
    var dataChanged: (() -> Void)?
    var events = [Event]()
    
    /// Fetch data from SeatGeak API
    func fetch(_ url: String) {
        let decoder = JSONDecoder()
        decoder.decode(APIResult.self, fromURL: url) { (events) in
            self.events = events.events
            
            self.dataChanged?()
        }
    }
    
    
    func eventCell(_ cell: UITableViewCell, button: UIButton) {
        guard let indexPath = tableView?.indexPath(for: cell) else { return }
        let event = events[indexPath.row]
        FirebaseLayer.isEventLiked(event: event) { (isLiked) in
            if isLiked {
                FirebaseLayer.remove(event: event) {
                    button.setBackgroundImage(UIImage(named: "like"), for: .normal)
//                    self.dataChanged?()
                }
            } else {
                FirebaseLayer.add(event: event) {
                    button.setBackgroundImage(UIImage(named: "liked"), for: .normal)
//                    self.dataChanged?()
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.setCell(event: event)
        
        cell.delegate = self
        
        return cell
    }
    
    
}
