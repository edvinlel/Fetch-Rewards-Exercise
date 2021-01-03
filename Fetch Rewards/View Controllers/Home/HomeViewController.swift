//
//  HomeViewController.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/17/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit
import CoreLocation

// seatgeek secret = 801c9169205e9ba40561e32bc8fe725877f4885d40056ad58cb48672edb3dece
// seatgeek clientid = NzU4MDk0M3wxNjA4MjQ5MDY0LjU2Mjg0NDM

class HomeViewController: UIViewController, EventCellDelegate {
    
    
    
    // MARK: Properties
    weak var homeView: HomeView! { return self.view as? HomeView }
    private let locationManager = CLLocationManager()
    var events = [Event]()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = HomeView()
        var originalString = "new york yankees"
        var urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(urlString)
        
        getEvents()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatter.date(from: "2017-01-09T11:00:00") {
            print(dateFormatterPrint.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
        
        homeView.searchBar.delegate = self
        homeView.eventTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = self
    }
    
    // MARK: Helper Functions
    func eventCell(_ cell: UITableViewCell, button: UIButton) {
        button.setBackgroundImage(UIImage(named: "liked"), for: .normal)
//        guard let indexPath = homeView.eventTableView.indexPath(for: cell) else { return }
//        print(indexPath)
    }
    
    private func getEvents() {
        NetworkManager.shared.getEvents { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                self.events = events
                DispatchQueue.main.async {
                    self.homeView.eventTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as! EventCell
        cell.eventImageView.image = UIImage(named: "snoop")
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventViewController = EventViewController()
        navigationController?.pushViewController(eventViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)-> Void in
//                    if error != nil {
//                        println("Reverse geocoder failed with error: \(error.localizedDescription)")
//                        return
//                    }
//
//                    if placemarks.count > 0 {
//                        let placemark = placemarks[0] as! CLPlacemark
//                        self.locationManager.stopUpdatingLocation()
//                        self.postalCode = (placemark.postalCode != nil) ? placemark.postalCode : ""
//                        println("Postal code updated to: \(self.postalCode)")
//                    }else{
//                        println("No placemarks found.")
//                    }
//                })
    }
}
