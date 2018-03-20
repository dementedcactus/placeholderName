//
//  ChatTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "user")
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        //label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    lazy var otherUserImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "user")
        return imageView
    }()
    
    lazy var otherUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var otherDateLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var otherCommentLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
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
        setupUserImageView()
        setupOtherUserImageView()
        setupUsernameLabel()
        setupOtherUsernameLabel()
        setupDateLabel()
        setupOtherDateLabel()
        setupCommentLabel()
        setupOtherCommentLabel()
    }
    
    //right side
    private func setupUserImageView() {
        addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        userImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
    }
    //other user - left side
    private func setupOtherUserImageView() {
        addSubview(otherUserImageView)
        otherUserImageView.translatesAutoresizingMaskIntoConstraints = false
        otherUserImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        otherUserImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        otherUserImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        otherUserImageView.widthAnchor.constraint(equalTo: otherUserImageView.heightAnchor).isActive = true
    }
    
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.trailingAnchor.constraint(equalTo: userImageView.leadingAnchor, constant: -4).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
    }
    
    private func setupOtherUsernameLabel() {
        addSubview(otherUsernameLabel)
        otherUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        otherUsernameLabel.leadingAnchor.constraint(equalTo: otherUserImageView.trailingAnchor, constant: 4).isActive = true
        otherUsernameLabel.bottomAnchor.constraint(equalTo: otherUserImageView.bottomAnchor).isActive = true
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: userImageView.topAnchor).isActive = true
    }
    
    private func setupOtherDateLabel() {
        addSubview(otherDateLabel)
        otherDateLabel.translatesAutoresizingMaskIntoConstraints = false
        otherDateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        otherDateLabel.bottomAnchor.constraint(equalTo: otherUserImageView.topAnchor).isActive = true
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        commentLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    private func setupOtherCommentLabel() {
        addSubview(otherCommentLabel)
        otherCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        otherCommentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        otherCommentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        otherCommentLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    //TODO: Configure cell for user & other user
    public func configureUserCell() {
        self.userImageView.image = #imageLiteral(resourceName: "user")
        self.dateLabel.text = "3/3/18"
        self.usernameLabel.text = "user"
        self.commentLabel.text = "user comment"
    }
    
    public func configureOtherUserCell() {
        self.otherUserImageView.image = #imageLiteral(resourceName: "user")
        self.otherDateLabel.text = "other 3/3/18"
        self.otherUsernameLabel.text = "other user"
        self.otherCommentLabel.text = "other user comment"
    }

}
