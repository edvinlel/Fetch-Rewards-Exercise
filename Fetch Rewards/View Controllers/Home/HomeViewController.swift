//
//  HomeViewController.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/17/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase



class HomeViewController: UIViewController {
    // MARK: Properties
    weak var homeView: HomeView! { return self.view as? HomeView }
    private let locationManager = CLLocationManager()
    private let dataSource = EventDataSource()
    var isComingFromSearch = false
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = HomeView()
        
        homeView.searchBar.delegate = self
        homeView.eventTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = dataSource
        dataSource.tableView = homeView.eventTableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isComingFromSearch == false {
            reloadData()
            dataSource.fetch("https://api.seatgeek.com/2/events?client_id=\(SeatGeekAPI.clientID)&per_page=100")
            isComingFromSearch = false
        }
    }
    
    // MARK: Helper Functions
    private func reloadData() {
        dataSource.dataChanged = { [weak self] in
            self?.dataSource.tableView?.reloadData()
        }
    }

    
}

// MARK: TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = dataSource.events[indexPath.row]
        
        let eventViewController = EventViewController()
        eventViewController.event = event
        
        navigationController?.pushViewController(eventViewController, animated: false)
    }
}

// MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    private func clearSearchBar(searchBar: UISearchBar, fetchData: Bool) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearchBar(searchBar: searchBar, fetchData: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let text = searchText.replacingOccurrences(of: " ", with: "+")
        
        dataSource.fetch("https://api.seatgeek.com/2/events?client_id=\(SeatGeekAPI.clientID)&per_page=100&q=\(text)")
        reloadData()
        
        clearSearchBar(searchBar: searchBar, fetchData: true)
        
        isComingFromSearch = true
    }
}


