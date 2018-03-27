//
//  VenueDetailViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    let venueDetailView = VenueDetailView()
    let dummyData = ["test1", "test2", "test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(venueDetailView)
        venueDetailView.tableView.delegate = self
        venueDetailView.tableView.dataSource = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Venue Detail Page"
    }
    
}
extension VenueDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Venue Detail Cell", for: indexPath)
        cell.textLabel?.text = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
}
