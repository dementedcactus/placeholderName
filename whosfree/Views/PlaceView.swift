//
//  VenueView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit

class PlaceView: UIView {

    lazy var placeSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Place"
        return searchBar
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.groupTableViewBackground
        searchBar.placeholder = "Enter location"
        return searchBar
    }()
    
    lazy var placesMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "Place Cell")
        return tableView
    }()
    
//    lazy var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        return indicator
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        //setupPlaceSearchBar()
        //setupLocationSearchBar()
        setupTableView()
        //setupActivityIndicator()
    }
    
    private func setupPlaceSearchBar() {
        addSubview(placeSearchBar)
        placeSearchBar.translatesAutoresizingMaskIntoConstraints = false
        placeSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        placeSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        placeSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupLocationSearchBar() {
        addSubview(locationSearchBar)
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        locationSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        locationSearchBar.topAnchor.constraint(equalTo: placeSearchBar.bottomAnchor).isActive = true
        locationSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupMapView() {
        addSubview(placesMapView)
        placesMapView.translatesAutoresizingMaskIntoConstraints = false
        placesMapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        placesMapView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor).isActive = true
        placesMapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        placesMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
//    private func setupActivityIndicator() {
//        addSubview(activityIndicator)
//        //activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
//        activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
//    }
    
}
