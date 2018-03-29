//
//  FriendsCollectionViewCell.swift
//  whosfree
//
//  Created by Maryann Yin on 3/19/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    lazy var friendImage: UIImageView = {
        let fImage = UIImageView()
        fImage.image = #imageLiteral(resourceName: "profileImagePlaceholder")
        fImage.contentMode = .scaleAspectFill
        fImage.clipsToBounds = true
        return fImage
    }()
    
    lazy var friendLabel: UILabel = {
        let fLabel = UILabel()
        fLabel.text = "Bob"
        fLabel.numberOfLines = 0
        fLabel.textAlignment = .center
        fLabel.textColor = UIColor.white
        fLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20.0)!
        fLabel.backgroundColor = Stylesheet.Colors.LightBlue
        return fLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.groupTableViewBackground
        setupCellLayerAttributes()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayerAttributes() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    private func setupViews() {
        setupCFImage()
        setupCFLabel()
    }
    
    private func setupCFImage() {
        addSubview(friendImage)
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        friendImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
//        friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        friendImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        friendImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        friendImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        friendImage.widthAnchor.constraint(equalTo: friendImage.heightAnchor).isActive = true
    }
    
    private func setupCFLabel() {
        addSubview(friendLabel)
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        friendLabel.topAnchor.constraint(equalTo: friendImage.bottomAnchor, constant: 5).isActive = true
        friendLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        friendLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        friendLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}


