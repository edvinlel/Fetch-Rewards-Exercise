//
//  HomeView.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/17/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    // MARK: Properties
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search Events"
        bar.searchBarStyle = .minimal
        bar.showsCancelButton = true
        bar.barTintColor = .black
        return bar
    }()
    
    let eventTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.FetchRewardsColor.background
        return tableView
    }()
   
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.FetchRewardsColor.background
        
        setSubviewsForAutoLayout([searchBar, eventTableView])
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Constraints
    private func setConstraints() {
        /// Search Bar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        /// Event TableView
        NSLayoutConstraint.activate([
            eventTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            eventTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            eventTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            eventTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
