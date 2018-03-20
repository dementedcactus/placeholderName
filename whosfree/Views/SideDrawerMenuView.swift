//
//  SideDrawerMenuView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class SideDrawerMenuView: UIView {
 
    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.910, green: 0.412, blue: 0.204, alpha: 1.00)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "profileImagePlaceholder")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Username"
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = UIColor(red: 0.263, green: 0.553, blue: 0.576, alpha: 1.00)
        return lb
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    lazy var numFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Num Friends", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.553, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        setupBlurEffectView()
        setupObjects()
        constrainObjects()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.roundCorners([.bottomRight, .topRight], radius: 20)
        menuImageView.roundCorners([.topRight], radius: 20)
    }
    
    private func setupObjects() {
        addSubview(dismissView)
        addSubview(containerView)
        addSubview(menuImageView)
        addSubview(usernameLabel)
        addSubview(profileButton)
        addSubview(numFriendsButton)
        addSubview(logoutButton)
    }
    
    private func constrainObjects() {
        
        //ARRAY MUST BE IN ORDER!!
        let menuViewObjects = [containerView, menuImageView, usernameLabel, profileButton, numFriendsButton, logoutButton] as [UIView]
        
        menuViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //containerView
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            
            //menuImageView
            menuImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            menuImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            menuImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            menuImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3),
            
            //usernameLabel
            usernameLabel.topAnchor.constraint(equalTo: menuImageView.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            usernameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            usernameLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1),
            
            //profileButton
            profileButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            profileButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            profileButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1),
            
            //numFriendsButton
            numFriendsButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor),
            numFriendsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            numFriendsButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            numFriendsButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1),
            
            //logout
            logoutButton.topAnchor.constraint(equalTo: numFriendsButton.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoutButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            logoutButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1)
            
            ])
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

