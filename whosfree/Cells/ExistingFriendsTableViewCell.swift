//
//  ExistingFriendsTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/19/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

protocol ExistingFriendsTableViewCellDelegate: class {
    func addedFriendToInviteList(_ tag: Int)
}

class ExistingFriendsTableViewCell: UITableViewCell {
    
    weak var delegate: ExistingFriendsTableViewCellDelegate?

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
    
    //inviteButton
    lazy var inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Invite Friend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(addFriendToInviteListPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func addFriendToInviteListPressed() {
        delegate?.addedFriendToInviteList(self.tag)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "ExistingFriendsTableViewCell")
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
        addSubview(inviteButton)
        addSubview(usernameLabel)
    }
    
    private func constrainObjects() {
        
        //ARRAY MUST BE IN ORDER!!
        let friendCellObjects = [userPhotoImageView,inviteButton,usernameLabel] as [UIView]
        
        friendCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //userPhotoImageView
            userPhotoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userPhotoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            userPhotoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            userPhotoImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            userPhotoImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            //inviteButton
            inviteButton.centerYAnchor.constraint(equalTo: self.userPhotoImageView.centerYAnchor),
            inviteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            inviteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            inviteButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            inviteButton.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 5),
            inviteButton.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -5),
            
            //usernameLabel
            usernameLabel.centerYAnchor.constraint(equalTo: self.inviteButton.centerYAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: self.inviteButton.leadingAnchor, constant: -5),
            usernameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
            
            ])
    }
    
}

