//
//  ProfileView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    lazy var userProfileImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = #imageLiteral(resourceName: "profileImagePlaceholder")
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    lazy var usernameTextField: UITextField = {
        let unTextfield = UITextField()
        unTextfield.autocapitalizationType = .none
        unTextfield.autocorrectionType = .no
        unTextfield.placeholder = "placeholder_name"
        unTextfield.textAlignment = .center
        unTextfield.textColor = UIColor.black
        unTextfield.font = UIFont(name: "AppleSDGothicNeo-Regular", size: UIFont.systemFontSize)!
        unTextfield.backgroundColor = UIColor.clear
        return unTextfield
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let pTextField = UITextField()
        pTextField.autocapitalizationType = .none
        pTextField.autocorrectionType = .no
        pTextField.placeholder = "555-555-5555"
        pTextField.textAlignment = .center
        pTextField.textColor = UIColor.black
        pTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: UIFont.systemFontSize)!
        pTextField.backgroundColor = UIColor.clear
        return pTextField
    }()
    
    lazy var emailTextField: UITextField = {
        let eTextField = UITextField()
        eTextField.autocapitalizationType = .none
        eTextField.autocorrectionType = .no
        eTextField.placeholder = "placeholderName@placeholder.com"
        eTextField.textAlignment = .center
        eTextField.textColor = UIColor.black
        eTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: UIFont.systemFontSize)!
        eTextField.backgroundColor = UIColor.clear
        return eTextField
    }()
    
    lazy var friendsButton: UIButton = {
        let fButton = UIButton()
        fButton.setTitle("Friends", for: UIControlState.normal)
        fButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: UIFont.systemFontSize)!
        fButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        fButton.backgroundColor = UIColor.blue
        fButton.layer.borderColor = UIColor.white.cgColor
        fButton.layer.borderWidth = 2
        return fButton
    }()
    
    lazy var mutualFriendsButton: UIButton = {
        let mfButton = UIButton()
        mfButton.setTitle("Mutual Friends", for: UIControlState.normal)
        mfButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: UIFont.systemFontSize)!
        mfButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        mfButton.backgroundColor = UIColor.blue
        mfButton.layer.borderColor = UIColor.white.cgColor
        mfButton.layer.borderWidth = 2
        return mfButton
    }()
    
    lazy var friendsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.register(FriendsCollectionViewCell.self, forCellWithReuseIdentifier: "FriendsCollectionViewCell")
        return cv
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupProfileImage()
        setupUsernameTextField()
        setupPhoneTextField()
        setupEmailTextField()
        setupFriendsCollectionView()
        setupFriendsButton()
        setupMutualFriendsButton()
    }
    
    private func setupProfileImage() {
        addSubview(userProfileImage)
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        userProfileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        userProfileImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        userProfileImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setupUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant: 5).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupPhoneTextField() {
        addSubview(phoneNumberTextField)
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor).isActive = true
        phoneNumberTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor).isActive = true
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor).isActive = true
    }
    
    private func setupFriendsCollectionView() {
        addSubview(friendsCollectionView)
        friendsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        friendsCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
        friendsCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        friendsCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        friendsCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        friendsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupFriendsButton() {
        addSubview(friendsButton)
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
        friendsButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        friendsButton.bottomAnchor.constraint(equalTo: friendsCollectionView.topAnchor).isActive = true
        friendsButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        friendsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        friendsButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor).isActive = true
    }
    
    private func setupMutualFriendsButton() {
        addSubview(mutualFriendsButton)
        mutualFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        mutualFriendsButton.topAnchor.constraint(equalTo: friendsButton.topAnchor).isActive = true
        mutualFriendsButton.bottomAnchor.constraint(equalTo: friendsCollectionView.topAnchor).isActive = true
        mutualFriendsButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        mutualFriendsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        mutualFriendsButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor).isActive = true
    }
    
}
