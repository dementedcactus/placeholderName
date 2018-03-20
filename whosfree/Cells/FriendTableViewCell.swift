//
//  FriendTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    //userPhotoImageView
    lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //usernameLabel
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Bob"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.numberOfLines = 0
        lb.backgroundColor = .clear
        return lb
    }()
    
    //sendFriendRequestButton
    lazy var sendFriendRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Friend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        button.layer.borderWidth = 1
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "FriendCell")
        setupObjects()
        constrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupObjects()
        constrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupObjects()
        constrainObjects()
    }
    
    private func setupObjects(){
        addSubview(userPhotoImageView)
        addSubview(sendFriendRequestButton)
        addSubview(usernameLabel)
    }
    
    private func constrainObjects() {
        
        //ARRAY MUST BE IN ORDER!!
        let friendCellObjects = [userPhotoImageView,sendFriendRequestButton,usernameLabel] as [UIView]
        
        friendCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //userPhotoImageView
            userPhotoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userPhotoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            userPhotoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            userPhotoImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            userPhotoImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            //sendFriendRequestButton
            sendFriendRequestButton.centerYAnchor.constraint(equalTo: self.userPhotoImageView.centerYAnchor),
            sendFriendRequestButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            sendFriendRequestButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            sendFriendRequestButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            sendFriendRequestButton.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 5),
            sendFriendRequestButton.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -5),
            
            //usernameLabel
            usernameLabel.centerYAnchor.constraint(equalTo: self.sendFriendRequestButton.centerYAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: self.sendFriendRequestButton.leadingAnchor, constant: -5),
            usernameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
            
            ])
    }
    
}


