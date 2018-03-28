//
//  VenueTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/27/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    // label
    lazy var venueLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Here"
        Stylesheet.Objects.Labels.VenueLabel.style(label: lb)
        return lb
    }()
    
    // detail label
    lazy var venueDetailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Details Here"
        Stylesheet.Objects.Labels.VenueDetailLabel.style(label: lb)
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "Venue Cell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        addSubview(venueLabel)
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
        venueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        venueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        venueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(venueDetailLabel)
        venueDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        venueDetailLabel.topAnchor.constraint(equalTo: venueLabel.topAnchor).isActive = true
        venueDetailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        venueDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        venueDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
