//
//  VenueDetailViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class placeDetailViewController: UIViewController {

    let placeDetailView = PlaceDetailView()
    let dummyData = ["test1", "test2", "test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(placeDetailView)
        placeDetailView.tableView.delegate = self
        placeDetailView.tableView.dataSource = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Place Detail Page"
    }
    
}
extension placeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Place Detail Cell", for: indexPath)
        cell.textLabel?.text = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
}
