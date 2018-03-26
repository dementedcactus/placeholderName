//
//  ChatTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Kingfisher

class ChatTableViewCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "user")
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.LabelRight.style(label: label)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.LabelRight.style(label: label)
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        Stylesheet.Objects.Labels.CommentLabelRight.style(label: label)
        return label
    }()
    
    lazy var leftUserImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "user")
        return imageView
    }()
    
    lazy var leftUsernameLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.LabelLeft.style(label: label)
        return label
    }()
    
    lazy var leftDateLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.LabelLeft.style(label: label)
        return label
    }()
    
    lazy var leftCommentLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        Stylesheet.Objects.Labels.CommentLabelLeft.style(label: label)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "ChatTableViewCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupViews() {
        setupContainerView()
        
        setupDateLabel()
        setupOtherDateLabel()
        setupUserImageView()
        setupOtherUserImageView()
        setupUsernameLabel()
        setupOtherUsernameLabel()
        setupCommentLabel()
        setupOtherCommentLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupDateLabel() {
        containerView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setupOtherDateLabel() {
        containerView.addSubview(leftDateLabel)
        leftDateLabel.translatesAutoresizingMaskIntoConstraints = false
        leftDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        leftDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftDateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    //right side
    private func setupUserImageView() {
        containerView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        userImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
    }
    //other user - left side
    private func setupOtherUserImageView() {
        containerView.addSubview(leftUserImageView)
        leftUserImageView.translatesAutoresizingMaskIntoConstraints = false
        leftUserImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        leftUserImageView.topAnchor.constraint(equalTo: leftDateLabel.bottomAnchor, constant: 2).isActive = true
        leftUserImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftUserImageView.widthAnchor.constraint(equalTo: leftUserImageView.heightAnchor).isActive = true
    }
    
    private func setupUsernameLabel() {
        containerView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.trailingAnchor.constraint(equalTo: userImageView.leadingAnchor, constant: -5).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
    }
    
    private func setupOtherUsernameLabel() {
        containerView.addSubview(leftUsernameLabel)
        leftUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        leftUsernameLabel.leadingAnchor.constraint(equalTo: leftUserImageView.trailingAnchor, constant: 5).isActive = true
        leftUsernameLabel.bottomAnchor.constraint(equalTo: leftUserImageView.bottomAnchor).isActive = true
        leftUsernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    private func setupCommentLabel() {
        containerView.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        commentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func setupOtherCommentLabel() {
        containerView.addSubview(leftCommentLabel)
        leftCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        leftCommentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        leftCommentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        leftCommentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        leftCommentLabel.topAnchor.constraint(equalTo: leftUsernameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    //TODO: Configure cell for user & other user
    public func configureUserCell(comment: Comment) {
        self.usernameLabel.text = comment.userID // In case user doesn't have displayName
        self.userImageView.image = #imageLiteral(resourceName: "chatBubble") // Default Image
        self.userImageView.kf.indicatorType = .activity
        DatabaseService.manager.getUserProfile(withUID: comment.userID!) { (data) in
            self.usernameLabel.text = data.displayName
            self.userImageView.kf.setImage(with: URL(string: data.profileImageUrl), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            })
        }
        self.dateLabel.text = "\(comment.timestamp)"
        self.commentLabel.text = comment.text
        self.leftUserImageView.isHidden = true
        self.leftDateLabel.isHidden = true
        self.leftUsernameLabel.isHidden = true
        self.leftCommentLabel.isHidden = true
        self.userImageView.isHidden = false
        self.dateLabel.isHidden = false
        self.usernameLabel.isHidden = false
        self.commentLabel.isHidden = false
        self.backgroundColor = .white
    }
    
    public func configureOtherUserCell(comment: Comment) {
        
        self.leftUsernameLabel.text = comment.userID // In case user doesn't have displayName
        self.leftUserImageView.image = #imageLiteral(resourceName: "chatBubble") // Default Image
         self.leftUserImageView.kf.indicatorType = .activity
         DatabaseService.manager.getUserProfile(withUID: comment.userID!) { (data) in
         self.leftUsernameLabel.text = data.displayName
         self.leftUserImageView.kf.setImage(with: URL(string: data.profileImageUrl), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
         })
         }
        
        self.leftDateLabel.text = "\(comment.timestamp)"
        self.leftCommentLabel.text = comment.text
        
        self.userImageView.isHidden = true
        self.dateLabel.isHidden = true
        self.usernameLabel.isHidden = true
        self.commentLabel.isHidden = true
        self.leftUserImageView.isHidden = false
        self.leftDateLabel.isHidden = false
        self.leftUsernameLabel.isHidden = false
        self.leftCommentLabel.isHidden = false
        self.backgroundColor = UIColor(red: 0.945, green: 0.941, blue: 0.941, alpha: 1.00)
    }
    
}
