//
//  VenueTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/27/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    //userPhotoImageView
    lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // label
    lazy var placeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Name"
        Stylesheet.Objects.Labels.PlaceLabel.style(label: lb)
        return lb
    }()
    
    // subtitlelabel
    lazy var subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Details"
        Stylesheet.Objects.Labels.PlaceDetailLabel.style(label: lb)
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
        addSubview(placeImageView)
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        placeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        placeImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        placeImageView.heightAnchor.constraint(equalTo: placeImageView.widthAnchor).isActive = true
        
        addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 5).isActive = true
        placeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46).isActive = true
        
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 1).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 5).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        addSubview(selectPlaceButton)
        selectPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        //selectPlaceButton.topAnchor.constraint(equalTo: placeLabel.topAnchor).isActive = true
        selectPlaceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectPlaceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        selectPlaceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectPlaceButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.24).isActive = true
        
    }
}
