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
    
    // more details label
    lazy var moreDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "More Venue Info..."
        label.font = Stylesheet.Fonts.Regular
        label.textColor = Stylesheet.Colors.Dark
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // select venue button
    lazy var selectVenueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Venue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        button.layer.borderWidth = 1
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
        //placeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        placeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        addSubview(placeDetailLabel)
        placeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        placeDetailLabel.topAnchor.constraint(equalTo: placeLabel.topAnchor, constant: 5).isActive = true
        placeDetailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        placeDetailLabel.trailingAnchor.constraint(equalTo: placeLabel.trailingAnchor).isActive = true
        placeDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(selectVenueButton)
        selectVenueButton.translatesAutoresizingMaskIntoConstraints = false
        selectVenueButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        selectVenueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        selectVenueButton.heightAnchor.constraint(equalTo: placeLabel.heightAnchor).isActive = true
        selectVenueButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
        addSubview(moreDetailsLabel)
        moreDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        moreDetailsLabel.topAnchor.constraint(equalTo: selectVenueButton.bottomAnchor, constant: 5).isActive = true
        moreDetailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        moreDetailsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        moreDetailsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        
    }
}
