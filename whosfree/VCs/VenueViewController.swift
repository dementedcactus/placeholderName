//
//  VenueViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController {

    let venueView = VenueView()
    let dummyData = ["test1", "test2", "test3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(venueView)
        venueView.tableView.dataSource = self
        venueView.tableView.delegate = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        let showVenuesTableViewBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "tableView"), style: .plain, target: self, action: #selector(showVenuesTableView))
        navigationItem.rightBarButtonItem = showVenuesTableViewBarButton
        navigationItem.title = "Venue Search"
    }
    
    @objc private func showVenuesTableView() {
        //unhide tableView
    }
}
extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let testData = dummyData[indexPath.row]
        let cell = venueView.tableView.dequeueReusableCell(withIdentifier: "Venue Cell", for: indexPath)
        cell.textLabel?.text = testData
        return cell
    }
    

}
