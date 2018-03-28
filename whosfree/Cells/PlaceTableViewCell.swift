//
//  VenueTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/27/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    // label
    lazy var placeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Here"
        Stylesheet.Objects.Labels.PlaceLabel.style(label: lb)
        return lb
    }()
    
    // detail label
    lazy var placeDetailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Details Here"
        Stylesheet.Objects.Labels.PlaceDetailLabel.style(label: lb)
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "Place Cell")
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
        addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(placeDetailLabel)
        placeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        placeDetailLabel.topAnchor.constraint(equalTo: placeLabel.topAnchor).isActive = true
        placeDetailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        placeDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
