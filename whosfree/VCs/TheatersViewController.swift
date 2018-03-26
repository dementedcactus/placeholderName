//
//  TheatersViewController.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class TheatersViewController: UIViewController {
    
    let theatersView = TheatersView()
    
    var theaters = [Theater]() {
        didSet {
            DispatchQueue.main.async {
                self.theatersView.theatersTableView.reloadData()
            }
        }
    }
    
    var zipcodeStr: String = "" {
        didSet {
            TheaterAPIClient.manager.getTheaters(with: zipcodeStr, and: "5", success: { self.theaters = $0 }, failure: { print($0) })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(theatersView)
        theatersView.theaterSearchBar.delegate = self
        theatersView.theatersTableView.delegate = self
        theatersView.theatersTableView.dataSource = self
        configureNavBar()
        TheaterAPIClient.manager.getTheaters(with: "11385", and: "5", success: { self.theaters = $0 }, failure: { print($0) })
    }
    
    private func configureNavBar() {
        navigationItem.titleView = theatersView.theaterSearchBar
    }
    
}

extension TheatersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theaters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theaterCell = tableView.dequeueReusableCell(withIdentifier: "TheaterTableViewCell", for: indexPath) as! TheaterTableViewCell
        let currentTheater = theaters[indexPath.row]
        theaterCell.configureCell(theater: currentTheater)
        return theaterCell
    }
}

extension TheatersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theaterShowtimesVC = TheaterShowtimesViewController(theater: theaters[indexPath.row])
        navigationController?.pushViewController(theaterShowtimesVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension TheatersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        zipcodeStr = searchBar.text!
    }
}


