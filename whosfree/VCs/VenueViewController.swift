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
    var dummyData = [Venue]() {
        didSet {
            venueView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        self.view.addSubview(venueView)
        venueView.tableView.dataSource = self
        venueView.tableView.delegate = self
        venueView.venueSearchBar.delegate = self
        venueView.locationSearchBar.delegate = self
        
    }
    
}


extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let testData = dummyData[indexPath.row]
        let cell = venueView.tableView.dequeueReusableCell(withIdentifier: "Venue Cell", for: indexPath) as! VenueTableViewCell
        
        cell.venueLabel.text = testData.name
        cell.venueDetailLabel.text = testData.phone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venueDetailVC = VenueDetailViewController()
        navigationController?.pushViewController(venueDetailVC, animated: true)
    }
    
}
extension VenueViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        becomeFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO
        if venueView.venueSearchBar.text == "" || venueView.locationSearchBar.text == "" {
            let alertView = UIAlertController(title: "Please enter text into both search fields", message: nil, preferredStyle: .alert)
            let noOption = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(noOption)
            present(alertView, animated: true, completion: nil)
        } else {
            VenueAPIClient.manager.getVenues(with: venueView.venueSearchBar.text!, and: venueView.locationSearchBar.text!, success: { (venueData) in
                self.dummyData = venueData
            }, failure: {print($0)})
        }
        resignFirstResponder()
    }
}
