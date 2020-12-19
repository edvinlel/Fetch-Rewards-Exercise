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

    /// Initialize uiview with properties and constraints for view controller
    weak var homeView: HomeView! { return self.view as? HomeView }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = HomeView()
        
        homeView.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for subView in homeView.searchBar.subviews  {
            for subsubView in subView.subviews  {
                if let _ = subsubView as? UITextInputTraits {
                    let textField = subsubView as! UITextField
                    var bounds: CGRect
                    bounds = textField.frame

                    //2. Shorter textfield in height
                    bounds.size.height = 40
                    textField.bounds = bounds

                    //3. Textfield to have less corner radious
                    textField.layer.cornerRadius = 5 //Probably you can play with this and see the changes.
                    textField.clipsToBounds = true
                }
                
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
