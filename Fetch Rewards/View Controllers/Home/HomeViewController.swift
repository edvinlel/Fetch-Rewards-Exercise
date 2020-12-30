//
//  HomeViewController.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/17/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

// seatgeek secret = 801c9169205e9ba40561e32bc8fe725877f4885d40056ad58cb48672edb3dece
// seatgeek clientid = NzU4MDk0M3wxNjA4MjQ5MDY0LjU2Mjg0NDM

class HomeViewController: UIViewController {
    
    // MARK: Properties
    weak var homeView: HomeView! { return self.view as? HomeView }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = HomeView()
        
        homeView.searchBar.delegate = self
        homeView.eventTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = self
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
        cell.eventImageView.image = UIImage(named: "camping")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventViewController = EventViewController()
        navigationController?.pushViewController(eventViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
