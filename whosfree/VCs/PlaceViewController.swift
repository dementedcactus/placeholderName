//
//  VenueViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

protocol SelectVenueDelegate {
    func passSelectedVenueAddressToCreateEventSearchBar(addrsss: String, placeImageURL: String)
}

class PlaceViewController: UIViewController {
    
    var selectVenueDelegate: SelectVenueDelegate?
    let emptyView = EmptyStateView(emptyText: "Use the Searchbars Above to find a Place!")
    let placeView = PlaceView()
    var placeData = [Place]() {
        didSet {
            placeView.tableView.reloadData()
            emptyStateFunc()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyStateFunc()
    }
    
    private func emptyStateFunc(){
        if placeData.isEmpty {
            self.view.addSubview(emptyView)
            
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            emptyView.topAnchor.constraint(equalTo: placeView.locationSearchBar.bottomAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: placeView.bottomAnchor).isActive = true
            emptyView.leadingAnchor.constraint(equalTo: placeView.leadingAnchor).isActive = true
            emptyView.trailingAnchor.constraint(equalTo: placeView.trailingAnchor).isActive = true
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    private func setupView(){
        self.view.addSubview(placeView)
        placeView.tableView.dataSource = self
        placeView.tableView.delegate = self
        placeView.placeSearchBar.delegate = self
        placeView.locationSearchBar.delegate = self
        placeView.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}


extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = placeData[indexPath.row]
        let cell = placeView.tableView.dequeueReusableCell(withIdentifier: "Place Cell", for: indexPath) as! PlaceTableViewCell
        
        cell.selectPlaceButton.tag = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.placeLabel.text = "\(indexPath.row + 1). \(place.name)\n\(place.location.address1) \(place.location.city) \(place.location.zip_code) \n\nTap for more info... "
        cell.selectPlaceButton.addTarget(self, action: #selector(selectVenueAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func selectVenueAction(sender: UIButton!) {
        let place = placeData[sender.tag]
        let address = "\(place.location.address1) \(place.location.city) \(place.location.zip_code)"
        print(address)
        self.selectVenueDelegate?.passSelectedVenueAddressToCreateEventSearchBar(addrsss: address, placeImageURL: place.image_url)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = placeDetailViewController(place: placeData[indexPath.row])
        placeDetailVC.selectDetailVenueDelegate = self
        navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    
}
extension PlaceViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        becomeFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if placeView.placeSearchBar.text == "" || placeView.locationSearchBar.text == "" {
            let alertView = UIAlertController(title: "Please enter text into both search fields", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(ok)
            present(alertView, animated: true, completion: nil)
        } else {
            PlaceAPIClient.manager.getPlaces(with: placeView.placeSearchBar.text!, and: placeView.locationSearchBar.text!, success: { (venueData) in
                self.placeData = venueData
            }, failure: {print($0)})
        }
        searchBar.resignFirstResponder()
    }
}

extension PlaceViewController: SelectDetailVenueDelegate {
    func passSelectedDetailVenueAddressToCreateEventSearchBar(addrsss: String, placeImageURL: String) {
        selectVenueDelegate?.passSelectedVenueAddressToCreateEventSearchBar(addrsss: addrsss, placeImageURL: placeImageURL)
    }
    
}
