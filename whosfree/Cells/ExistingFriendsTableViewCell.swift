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
        button.setImage(#imageLiteral(resourceName: "friendAddButton"), for: .normal)
        button.addTarget(self, action: #selector(addFriendToInviteListPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func addFriendToInviteListPressed() {
        //self.inviteButton.backgroundColor = Stylesheet.Colors.NYCBlue
        //self.inviteButton.setTitle("Invited", for: .normal)
        //self.inviteButton.setImage(#imageLiteral(resourceName: "friendAddedButton"), for: .normal)
        UIView.transition(with: inviteButton, duration: 0.3,
                          options: .transitionFlipFromLeft,
                                  animations: {
                                    self.inviteButton.setImage(#imageLiteral(resourceName: "friendAddedButton"), for: .normal)
        }, completion: nil)
//        UIView.animate(withDuration: 0.25, animations: {
//            self.inviteButton.transform = CGAffineTransform(
//        })
        //UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
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
            
            //usernameLabel
            usernameLabel.centerYAnchor.constraint(equalTo: self.inviteButton.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.userPhotoImageView.trailingAnchor, constant: 5),
            usernameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
            
            ])
    }
}

