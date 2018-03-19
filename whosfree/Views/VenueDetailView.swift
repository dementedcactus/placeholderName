//
//  VenueDetailView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit

class VenueDetailView: UIView {
    
    lazy var venueImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venuePlaceHolder")
        return imageView
    }()
    
    lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Venue Name"
        return label
    }()
    
    lazy var venueAddressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Venue Address 34 st New York, NY 10020"
        return label
    }()
    
    lazy var venuePricePointLabel: UILabel = {
        let label = UILabel()
        label.text = "Price point $$"
        return label
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "phone"), for: .normal)
        return button
    }()
    
    lazy var callLabel: UILabel = {
        let label = UILabel()
        label.text = "Call"
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var sendLocationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Select Location", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10.0
        //button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    lazy var ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "fourStars")
        return imageView
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Venue Detail Cell")
        return tableView
    }()
    
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
        setupVenueImage()
        setupVenueLabel()
        setupRatingImage()
        setupVenueAddressLabel()
        setupVenuePricePointLabel()
        setupCallButton()
        setupCallLabel()
        setupSendLocationButton()
        setupMapView()
        setupRatingImage()
        setupTableView()
    }
    
    private func setupVenueImage() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        venueImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        venueImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        venueImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        venueImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupVenueLabel() {
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        venueNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        venueNameLabel.topAnchor.constraint(equalTo: venueImage.bottomAnchor, constant: 8).isActive = true
        venueNameLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupRatingImage() {
        addSubview(ratingImage)
        ratingImage.translatesAutoresizingMaskIntoConstraints = false
        ratingImage.leadingAnchor.constraint(equalTo: venueNameLabel.leadingAnchor).isActive = true
        ratingImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        ratingImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        ratingImage.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor).isActive = true
    }
    
    private func setupVenueAddressLabel() {
        addSubview(venueAddressLabel)
        venueAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        venueAddressLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        venueAddressLabel.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 5).isActive = true
        venueAddressLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupVenuePricePointLabel() {
        addSubview(venuePricePointLabel)
        venuePricePointLabel.translatesAutoresizingMaskIntoConstraints = false
        venuePricePointLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        venuePricePointLabel.topAnchor.constraint(equalTo: venueAddressLabel.bottomAnchor, constant: 5).isActive = true
        venuePricePointLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupCallButton() {
        addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 3).isActive = true
        callButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        callButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        callButton.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor).isActive = true
    }
    
    private func setupCallLabel() {
        addSubview(callLabel)
        callLabel.translatesAutoresizingMaskIntoConstraints = false
        callLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
        callLabel.widthAnchor.constraint(equalTo: callButton.widthAnchor, multiplier: 1).isActive = true
        callLabel.topAnchor.constraint(equalTo: callButton.bottomAnchor).isActive = true
        
    }
    
    private func setupSendLocationButton() {
        addSubview(sendLocationButton)
        sendLocationButton.translatesAutoresizingMaskIntoConstraints = false
        sendLocationButton.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        sendLocationButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4).isActive = true
        sendLocationButton.topAnchor.constraint(equalTo: venueAddressLabel.bottomAnchor).isActive = true
    }
    
    private func setupMapView() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: sendLocationButton.bottomAnchor, constant: 15).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }

}
