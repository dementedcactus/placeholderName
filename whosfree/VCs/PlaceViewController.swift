//
//  VenueViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

protocol SelectVenueDelegate {
    func passSelectedVenueAddressToCreateEventSearchBar(addrsss: String, placeImageURL: String)
}

class PlaceViewController: UIViewController {
    
    var zipCode: String = "11385"
    
    var searchActivityIndicator: UIActivityIndicatorView!
    
    var selectVenueDelegate: SelectVenueDelegate?
    let emptyView = EmptyStateView(emptyText: "Use the Searchbar Above to find a Place!")
    let placeView = PlaceView()
    var placeData = [Place]() {
        didSet {
            placeView.tableView.reloadData()
            //emptyStateFunc()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = LocationService.manager.checkForLocationServices()

        setupView()
        
        searchActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        searchActivityIndicator.center = view.center
        searchActivityIndicator.isHidden = true
        view.addSubview(searchActivityIndicator)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyStateFunc()
    }
    
    private func emptyStateFunc(){
        if placeData.isEmpty {
            self.view.addSubview(emptyView)
            
            emptyView.translatesAutoresizingMaskIntoConstraints = false
//            emptyView.topAnchor.constraint(equalTo: placeView.topAnchor).isActive = true
//            emptyView.bottomAnchor.constraint(equalTo: placeView.bottomAnchor).isActive = true
//            emptyView.leadingAnchor.constraint(equalTo: placeView.leadingAnchor).isActive = true
//            emptyView.trailingAnchor.constraint(equalTo: placeView.trailingAnchor).isActive = true
            emptyView.topAnchor.constraint(equalTo: placeView.tableView.topAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: placeView.tableView.bottomAnchor).isActive = true
            emptyView.leadingAnchor.constraint(equalTo: placeView.tableView.leadingAnchor).isActive = true
            emptyView.trailingAnchor.constraint(equalTo: placeView.tableView.trailingAnchor).isActive = true
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    private func setupView(){
        self.view.addSubview(placeView)
        navigationItem.titleView = placeView.placeSearchBar
        placeView.tableView.dataSource = self
        placeView.tableView.delegate = self
        placeView.placeSearchBar.delegate = self
        placeView.locationSearchBar.delegate = self
        placeView.tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "marker"), style: .done, target: self, action: #selector(showLocationSearchbar))
    }
    
    @objc private func showLocationSearchbar() {
        if placeView.locationSearchBar.isHidden {
            placeView.locationSearchBar.text = ""
            placeView.locationSearchBar.isHidden = false
            placeView.tableViewTopConstraint?.isActive = false
            placeView.tableViewTopConstraint = placeView.tableView.topAnchor.constraint(equalTo: placeView.locationSearchBar.bottomAnchor)
            placeView.tableViewTopConstraint?.isActive = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            //placeView.locationSearchBar.text = ""
            //placeView.locationSearchBar.isHidden = true
            placeView.tableViewTopConstraint?.isActive = false
            placeView.tableViewTopConstraint = placeView.tableView.topAnchor.constraint(equalTo: placeView.safeAreaLayoutGuide.topAnchor)
            placeView.tableViewTopConstraint?.isActive = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (bool) in
                self.placeView.locationSearchBar.isHidden = true
                self.placeView.locationSearchBar.text = ""
            })
        }

    }
    
}


extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = placeData[indexPath.row]
        let cell = placeView.tableView.dequeueReusableCell(withIdentifier: "Place Cell", for: indexPath) as! PlaceTableViewCell
        cell.selectPlaceButton.tag = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.placeLabel.text = "\(indexPath.row + 1). \(place.name)"
        cell.subtitleLabel.text = "\(place.location.address1 ?? ""), \(place.location.city), \(place.location.zip_code) \n\nTap for more info... "
        cell.selectPlaceButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.selectPlaceButton.addTarget(self, action: #selector(selectVenueAction(sender:)), for: .touchUpInside)
        cell.placeImageView.kf.indicatorType = .activity
        cell.placeImageView.kf.setImage(with: URL(string: place.image_url), placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cache, url) in
        }
        
        return cell
    }
    
    @objc func selectVenueAction(sender: UIButton!) {
        let place = placeData[sender.tag]
        let address = "\(place.location.address1 ?? "") \(place.location.city) \(place.location.zip_code)"
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
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        becomeFirstResponder()
//    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        placeData.removeAll()
        if !NetworkReachabilityManager()!.isReachable {
            showAlert(title: "No Network Detected", message: "Please check your internet connection")
            searchBar.resignFirstResponder()
            return
        }
        placeView.tableView.separatorStyle = .none
        emptyView.removeFromSuperview()
        searchActivityIndicator.isHidden = false
        searchActivityIndicator.startAnimating()
        
        if placeView.locationSearchBar.text == "" {
            let geocoder: CLGeocoder = CLGeocoder()
            let userLocation: CLLocation = CLLocation(latitude: LocationService.manager.getCurrentLatitude()!, longitude: LocationService.manager.getCurrentLongitude()!)
            geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.postalCode!)
                    PlaceAPIClient.manager.getPlaces(with: self.placeView.placeSearchBar.text!, and: pm.postalCode!, success: { (venueData) in
                        self.placeData = venueData
                        if venueData.count == 0 {
                            self.emptyView.emptyLabel.text = "No Results Found :("
                            self.view.addSubview(self.emptyView)
                            self.emptyView.translatesAutoresizingMaskIntoConstraints = false
//                            self.emptyView.topAnchor.constraint(equalTo: self.placeView.topAnchor).isActive = true
//                            self.emptyView.bottomAnchor.constraint(equalTo: self.placeView.bottomAnchor).isActive = true
//                            self.emptyView.leadingAnchor.constraint(equalTo: self.placeView.leadingAnchor).isActive = true
//                            self.emptyView.trailingAnchor.constraint(equalTo: self.placeView.trailingAnchor).isActive = true
                            self.emptyView.topAnchor.constraint(equalTo: self.placeView.tableView.topAnchor).isActive = true
                            self.emptyView.bottomAnchor.constraint(equalTo: self.placeView.tableView.bottomAnchor).isActive = true
                            self.emptyView.leadingAnchor.constraint(equalTo: self.placeView.tableView.leadingAnchor).isActive = true
                            self.emptyView.trailingAnchor.constraint(equalTo: self.placeView.tableView.trailingAnchor).isActive = true
                        }
                        self.searchActivityIndicator.isHidden = true
                        self.searchActivityIndicator.stopAnimating()
                        self.placeView.tableView.separatorStyle = .singleLine
                    }, failure: {print($0)})
                }
            }
        } else {
            PlaceAPIClient.manager.getPlaces(with: self.placeView.placeSearchBar.text!, and: self.placeView.locationSearchBar.text!, success: { (venueData) in
                self.placeData = venueData
                if venueData.count == 0 {
                    self.emptyView.emptyLabel.text = "No Results Found :("
                    self.view.addSubview(self.emptyView)
                    self.emptyView.translatesAutoresizingMaskIntoConstraints = false
//                    self.emptyView.topAnchor.constraint(equalTo: self.placeView.topAnchor).isActive = true
//                    self.emptyView.bottomAnchor.constraint(equalTo: self.placeView.bottomAnchor).isActive = true
//                    self.emptyView.leadingAnchor.constraint(equalTo: self.placeView.leadingAnchor).isActive = true
//                    self.emptyView.trailingAnchor.constraint(equalTo: self.placeView.trailingAnchor).isActive = true
                    self.emptyView.topAnchor.constraint(equalTo: self.placeView.tableView.topAnchor).isActive = true
                    self.emptyView.bottomAnchor.constraint(equalTo: self.placeView.tableView.bottomAnchor).isActive = true
                    self.emptyView.leadingAnchor.constraint(equalTo: self.placeView.tableView.leadingAnchor).isActive = true
                    self.emptyView.trailingAnchor.constraint(equalTo: self.placeView.tableView.trailingAnchor).isActive = true
                }
                self.searchActivityIndicator.isHidden = true
                self.searchActivityIndicator.stopAnimating()
                self.placeView.tableView.separatorStyle = .singleLine
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
