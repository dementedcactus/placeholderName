//
//  VenueDetailView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class PlaceDetailView: UIView {
    
    lazy var placeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venuePlaceHolder")
        return imageView
    }()
    
    lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Place Name"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 25)
        return label
    }()
    
    lazy var placeAddressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Venue Address 34 st New York, NY 10020"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()
    
    lazy var placePricePointLabel: UILabel = {
        let label = UILabel()
        label.text = "Price point $$"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
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
        button.setTitle("Select Place", for: .normal)
        button.backgroundColor = Stylesheet.Colors.azure
        button.layer.cornerRadius = 10.0
        //button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    lazy var ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "zeroStars")
        return imageView
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceReviewTableViewCell.self, forCellReuseIdentifier: "Review Cell")
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
        setupPlaceImage()
        setupPlaceLabel()
        setupRatingImage()
        setupPlaceAddressLabel()
        setupPlacePricePointLabel()
        setupCallButton()
        setupCallLabel()
        setupSendLocationButton()
        setupMapView()
        setupRatingImage()
        setupTableView()
    }
    
    private func setupPlaceImage() {
        addSubview(placeImage)
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        placeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        placeImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        placeImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupPlaceLabel() {
        addSubview(placeNameLabel)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        placeNameLabel.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 8).isActive = true
        placeNameLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupRatingImage() {
        addSubview(ratingImage)
        ratingImage.translatesAutoresizingMaskIntoConstraints = false
        ratingImage.leadingAnchor.constraint(equalTo: placeNameLabel.leadingAnchor).isActive = true
        ratingImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        ratingImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        ratingImage.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor).isActive = true
    }
    
    private func setupPlaceAddressLabel() {
        addSubview(placeAddressLabel)
        placeAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        placeAddressLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        placeAddressLabel.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 5).isActive = true
        placeAddressLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupPlacePricePointLabel() {
        addSubview(placePricePointLabel)
        placePricePointLabel.translatesAutoresizingMaskIntoConstraints = false
        placePricePointLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        placePricePointLabel.topAnchor.constraint(equalTo: placeAddressLabel.bottomAnchor, constant: 5).isActive = true
        placePricePointLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupCallButton() {
        addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 3).isActive = true
        callButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        callButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        callButton.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor).isActive = true
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
        sendLocationButton.topAnchor.constraint(equalTo: placeAddressLabel.bottomAnchor).isActive = true
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
        tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    public func configureView(with place: Place) {
        placeNameLabel.text = place.name
        placeAddressLabel.text = "Address: \(place.location.address1 ?? ""), \(place.location.city), \(place.location.zip_code)"
        placePricePointLabel.text = "Price: \(place.price ?? "N/A")"
        switch place.rating {
        case 0.0:
            ratingImage.image = #imageLiteral(resourceName: "zeroStars")
        case 0.5:
            ratingImage.image = #imageLiteral(resourceName: "halfStar")
        case 1.0:
            ratingImage.image = #imageLiteral(resourceName: "oneStar")
        case 1.5:
            ratingImage.image = #imageLiteral(resourceName: "oneAndAHalfStar")
        case 2.0:
            ratingImage.image = #imageLiteral(resourceName: "twoStars")
        case 2.5:
            ratingImage.image = #imageLiteral(resourceName: "twoAndAHalfStars")
        case 3.0:
            ratingImage.image = #imageLiteral(resourceName: "threeStars")
        case 3.5:
            ratingImage.image = #imageLiteral(resourceName: "threeAndAHalfStars")
        case 4.0:
            ratingImage.image = #imageLiteral(resourceName: "fourStars")
        case 4.5:
            ratingImage.image = #imageLiteral(resourceName: "fourAndAHalfStars")
        case 5.0:
            ratingImage.image = #imageLiteral(resourceName: "fiveStars")
        default:
            print("no review rating available")
        }
        let placeAnnotation = MKPointAnnotation()
        placeAnnotation.coordinate = CLLocationCoordinate2D(latitude: place.coordinates.latitude, longitude: place.coordinates.longitude)
        mapView.addAnnotation(placeAnnotation)
        let region = MKCoordinateRegion(center: placeAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        placeImage.kf.indicatorType = .activity
        placeImage.kf.setImage(with: URL(string: place.image_url), placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cache, url) in
        }
    }

}
