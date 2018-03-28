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
    var placeReviews = [Review]() {
        didSet {
            DispatchQueue.main.async {
                self.placeDetailView.tableView.reloadData()
            }
        }
    }
    
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
        PlaceReviewAPIClient.manager.getPlacesReviews(with: place.id, success: { self.placeReviews =  $0 }, failure: { print($0) })
    }
    
    private func configureNavBar() {
        navigationItem.title = "Place Detail Page"
    }
    
}
extension placeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = placeReviews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Review Cell", for: indexPath)
        cell.textLabel?.text = review.time_created
        cell.detailTextLabel?.text = review.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
}
