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
    
    //emailInviteButton
    lazy var inviteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "emailiconblue2"), for: .normal)
        button.addTarget(self, action: #selector(addFriendToInviteListPressed), for: .touchUpInside)
        return button
    }()
    
    //smsInviteButton
    lazy var smsInviteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "smsicon"), for: .normal)
        button.addTarget(self, action: #selector(addFriendToSMSInviteListPressed), for: .touchUpInside)
        //TODO: Switch to SMS Action then Enable
        //button.isEnabled = false
        return button
    }()
    
    @objc private func addFriendToInviteListPressed() {
        UIView.transition(with: inviteButton, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            if self.inviteButton.imageView?.image == #imageLiteral(resourceName: "friendAddedButton") {
                self.inviteButton.setImage(#imageLiteral(resourceName: "emailiconblue2"), for: .normal)
            } else {
                self.inviteButton.setImage(#imageLiteral(resourceName: "friendAddedButton"), for: .normal)
            }
        }, completion: nil)
        delegate?.addedFriendToInviteList(self.tag)
    }
    
    @objc private func addFriendToSMSInviteListPressed() {
        // TODO Make this actually send SMS
        UIView.transition(with: smsInviteButton, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            if self.smsInviteButton.imageView?.image == #imageLiteral(resourceName: "friendAddedButton") {
                self.smsInviteButton.setImage(#imageLiteral(resourceName: "smsicon"), for: .normal)
            } else {
                self.smsInviteButton.setImage(#imageLiteral(resourceName: "friendAddedButton"), for: .normal)
            }
        }, completion: nil)
        //delegate?.addedFriendToInviteList(self.tag)
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
        addSubview(smsInviteButton)
        addSubview(usernameLabel)
    }
    
    private func constrainObjects() {
        
        //ARRAY MUST BE IN ORDER!!
        let friendCellObjects = [userPhotoImageView,inviteButton,smsInviteButton,usernameLabel] as [UIView]
        
        friendCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            userPhotoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userPhotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            userPhotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor),
            
            //inviteButton
            inviteButton.centerYAnchor.constraint(equalTo: self.userPhotoImageView.centerYAnchor),
            inviteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            inviteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            inviteButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            //smsInviteButton
            smsInviteButton.centerYAnchor.constraint(equalTo: self.userPhotoImageView.centerYAnchor),
            smsInviteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            smsInviteButton.trailingAnchor.constraint(equalTo: inviteButton.leadingAnchor, constant: -8),
            smsInviteButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            //usernameLabel
            usernameLabel.centerYAnchor.constraint(equalTo: self.inviteButton.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.userPhotoImageView.trailingAnchor, constant: 5),
            usernameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
            
            ])
    }
}

