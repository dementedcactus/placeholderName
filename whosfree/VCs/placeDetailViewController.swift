//
//  VenueDetailViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit

protocol SelectDetailVenueDelegate {
    func passSelectedDetailVenueAddressToCreateEventSearchBar(addrsss: String, placeImageURL: String)
}

class placeDetailViewController: UIViewController {

    let placeDetailView = PlaceDetailView()
    var placeReviews = [Review]() {
        didSet {
            DispatchQueue.main.async {
                self.placeDetailView.tableView.reloadData()
            }
        }
    }
    
    var selectDetailVenueDelegate: SelectDetailVenueDelegate?
    
    var place: Place!
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(placeDetailView)
        placeDetailView.tableView.delegate = self
        placeDetailView.tableView.dataSource = self
        configureNavBar()
        placeDetailView.configureView(with: place)
        placeDetailView.mapView.delegate = self
        placeDetailView.callButton.addTarget(self, action: #selector(callPlace), for: .touchUpInside)
        placeDetailView.sendLocationButton.addTarget(self, action: #selector(selectPlace), for: .touchUpInside)
        PlaceReviewAPIClient.manager.getPlacesReviews(with: place.id, success: { self.placeReviews =  $0 }, failure: { print($0) })
    }
    
    private func configureNavBar() {
        navigationItem.title = "Place Detail Page"
    }
    
    @objc private func callPlace() {
        if let phoneCallURL = URL(string: "tel://\(place.phone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc private func selectPlace() {
        print("select place clicked")
        let address = "\(place.location.address1 ?? "") \(place.location.city) \(place.location.zip_code)"
        // delegate that uses Richards delegate to put location info on searchbar
        selectDetailVenueDelegate?.passSelectedDetailVenueAddressToCreateEventSearchBar(addrsss: address, placeImageURL: place.image_url)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
extension placeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = placeReviews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Review Cell", for: indexPath) as! PlaceReviewTableViewCell
        cell.configureCell(review: review)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
}

extension placeDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
            annotationView?.canShowCallout = true
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = Stylesheet.Colors.azure
            annotationView?.isHighlighted = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
