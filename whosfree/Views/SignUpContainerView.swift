//
//  SignUpContainerView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit

class SignUpContainerView: UIView {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profilePlaceholder")
        return imageView
    }()
    
    lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "First"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Enter first name"
        //textField.text = "Luis"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "Last"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Enter last name"
        //textField.text = "Calle"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "E-mail"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textAlignment = .right
        label.text = "Password"
        label.textColor = .black
        return label
    }()
    
    lazy var verifyPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textAlignment = .right
        label.text = "Verify password"
        label.textColor = .black
        return label
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Enter e-mail address"
        //textField.text = "luiscalle@ac.c4q.nyc"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var verifyPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Verify password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        //button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textField.placeholder = "Enter username"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "Username"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
        profileImageView.layer.masksToBounds = true
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
        setupEmailLoginTextField()
        setupEmailAddressLabel()
        setupPasswordTextField()
        setupPasswordLabel()
        setupVerifyPasswordTextField()
        setupVerifyPasswordLabel()
        setupSignUpButton()
        setupFirstNameTextField()
        setupFirstNameLabel()
        setupLastNameTextField()
        setupLastNameLabel()
        setupProfileImageView()
        setupUsernameTextField()
        setupUsernameLabel()
    }
    
    private func setupEmailLoginTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLoginTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            emailLoginTextField.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            emailLoginTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.75)
            ])
        
        //        addSubview(emailLoginTextField)
        //        emailLoginTextField.snp.makeConstraints { (make) in
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        //        }
    }
    
    private func setupEmailAddressLabel() {
        addSubview(emailAddressLabel)
        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailAddressLabel.topAnchor.constraint(equalTo: emailLoginTextField.bottomAnchor, constant: 2),
            emailAddressLabel.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(emailAddressLabel)
        //        emailAddressLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(emailLoginTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(emailLoginTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupFirstNameTextField() {
        addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameTextField.bottomAnchor.constraint(equalTo: emailLoginTextField.topAnchor, constant: -24),
            firstNameTextField.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor),
            firstNameTextField.widthAnchor.constraint(equalTo: emailLoginTextField.widthAnchor, multiplier: 0.48)
            ])
        
        //        addSubview(firstNameTextField)
        //        firstNameTextField.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(emailLoginTextField.snp.top).offset(-24)
        //            make.leading.equalTo(emailLoginTextField.snp.leading)
        //            make.width.equalTo(emailLoginTextField.snp.width).multipliedBy(0.48)
        //        }
    }
    
    private func setupFirstNameLabel() {
        addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 2),
            firstNameLabel.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor, constant: 8)
            ])
        //        addSubview(firstNameLabel)
        //        firstNameLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(firstNameTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(firstNameTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupLastNameTextField() {
        addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameTextField.bottomAnchor.constraint(equalTo: emailLoginTextField.topAnchor, constant: -24),
            lastNameTextField.trailingAnchor.constraint(equalTo: emailLoginTextField.trailingAnchor),
            lastNameTextField.widthAnchor.constraint(equalTo: emailLoginTextField.widthAnchor, multiplier: 0.48)
            ])
        
        //        addSubview(lastNameTextField)
        //        lastNameTextField.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(emailLoginTextField.snp.top).offset(-24)
        //            make.trailing.equalTo(emailLoginTextField.snp.trailing)
        //            make.width.equalTo(emailLoginTextField.snp.width).multipliedBy(0.48)
        //        }
    }
    
    private func setupLastNameLabel() {
        addSubview(lastNameLabel)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 2),
            lastNameLabel.leadingAnchor.constraint(equalTo: lastNameTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(lastNameLabel)
        //        lastNameLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(lastNameTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(lastNameTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailLoginTextField.widthAnchor)
            ])
        
        //        addSubview(passwordTextField)
        //        passwordTextField.snp.makeConstraints { (make) in
        //            make.top.equalTo(emailAddressLabel.snp.bottom).offset(8)
        //            make.leading.equalTo(emailLoginTextField.snp.leading)
        //            make.width.equalTo(emailLoginTextField.snp.width)
        //        }
    }
    
    private func setupPasswordLabel() {
        addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(passwordLabel)
        //        passwordLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(passwordTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupVerifyPasswordTextField() {
        addSubview(verifyPasswordTextField)
        verifyPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verifyPasswordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            verifyPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            verifyPasswordTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)
            ])
        
        //        addSubview(verifyPasswordTextField)
        //        verifyPasswordTextField.snp.makeConstraints { (make) in
        //            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
        //            make.leading.equalTo(passwordTextField.snp.leading)
        //            make.width.equalTo(passwordTextField.snp.width)
        //        }
    }
    
    private func setupVerifyPasswordLabel() {
        addSubview(verifyPasswordLabel)
        verifyPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verifyPasswordLabel.topAnchor.constraint(equalTo: verifyPasswordTextField.bottomAnchor, constant: 2),
            verifyPasswordLabel.leadingAnchor.constraint(equalTo: verifyPasswordTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(verifyPasswordLabel)
        //        verifyPasswordLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(verifyPasswordTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(verifyPasswordTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupSignUpButton() {
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: verifyPasswordLabel.bottomAnchor, constant: 10),
            signUpButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
            ])
        
        //        addSubview(signUpButton)
        //        signUpButton.snp.makeConstraints { (make) in
        //            make.top.equalTo(verifyPasswordLabel.snp.bottom).offset(10)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        //        }
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -24),
            profileImageView.centerXAnchor.constraint(equalTo: firstNameTextField.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: firstNameTextField.widthAnchor, multiplier: 0.8),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
            ])
        
        //        addSubview(profileImageView)
        //        profileImageView.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(firstNameTextField.snp.top).offset(-24)
        //            make.centerX.equalTo(firstNameTextField.snp.centerX)
        //            make.width.equalTo(firstNameTextField.snp.width).multipliedBy(0.8)
        //            make.height.equalTo(profileImageView.snp.width)
        //        }
    }
    
    private func setupUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: lastNameTextField.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: lastNameTextField.widthAnchor)
            ])
        
        //        addSubview(usernameTextField)
        //        usernameTextField.snp.makeConstraints { (make) in
        //            make.centerX.equalTo(lastNameTextField.snp.centerX)
        //            make.centerY.equalTo(profileImageView.snp.centerY)
        //            make.width.equalTo(lastNameTextField.snp.width)
        //        }
    }
    
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 2),
            usernameLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(usernameLabel)
        //        usernameLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(usernameTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(usernameTextField.snp.leading).offset(8)
        //        }
    }
    
}


