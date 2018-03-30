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
    
    // select venue button
    lazy var selectPlaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Place", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Stylesheet.Colors.LightBlue
        button.layer.cornerRadius = 10.0
        return button
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
        placeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        placeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.68).isActive = true
        placeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        addSubview(selectPlaceButton)
        selectPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        //selectPlaceButton.topAnchor.constraint(equalTo: placeLabel.topAnchor).isActive = true
        selectPlaceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectPlaceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        selectPlaceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectPlaceButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
    }
}
