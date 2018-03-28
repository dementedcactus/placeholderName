//
//  VenueViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
    
    let placeView = PlaceView()
    var placeData = [Place]() {
        didSet {
            placeView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        self.view.addSubview(placeView)
        placeView.tableView.dataSource = self
        placeView.tableView.delegate = self
        placeView.placeSearchBar.delegate = self
        placeView.locationSearchBar.delegate = self
        
    }
    
}


extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = placeData[indexPath.row]
        let cell = placeView.tableView.dequeueReusableCell(withIdentifier: "Place Cell", for: indexPath) as! PlaceTableViewCell
        
        cell.placeLabel.text = place.name
        cell.placeDetailLabel.text = "\(place.location.address1) \(place.location.city) \(place.location.zip_code)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = placeDetailViewController()
        navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
extension PlaceViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        becomeFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO
        if placeView.placeSearchBar.text == "" || placeView.locationSearchBar.text == "" {
            let alertView = UIAlertController(title: "Please enter text into both search fields", message: nil, preferredStyle: .alert)
            let noOption = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(noOption)
            present(alertView, animated: true, completion: nil)
        } else {
            PlaceAPIClient.manager.getPlaces(with: placeView.placeSearchBar.text!, and: placeView.locationSearchBar.text!, success: { (venueData) in
                self.placeData = venueData
            }, failure: {print($0)})
        }
        resignFirstResponder()
    }
}
