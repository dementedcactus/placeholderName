//
//  SignInContainerView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit
import FBSDKLoginKit
import FBSDKCoreKit

class SignInContainerView: UIView {
    
    lazy var emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "emailIcon-1")
        return imageView
    }()
    
    
    lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "passwordIcon")
        return imageView
    }()
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "E-mail"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var passwordAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textAlignment = .right
        label.text = "Password"
        label.textColor = .black
        return label
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        //textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        textField.placeholder = "Enter e-mail address"
        textField.textAlignment = .center
        textField.text = "luiscalle@ac.c4q.nyc"
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
        //textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        textField.placeholder = "Enter password"
        textField.textAlignment = .center
        textField.text = "123456"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        //button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        //button.titleLabel!.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var facebookLoginButton: FBSDKLoginButton = {
        let loginButton = FBSDKLoginButton()
        return loginButton
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
        setupPasswordTextField()
        setupPasswordAddressLabel()
        setupEmailAddressLabel()
        setupEmailLoginTextField()
        setupLoginButton()
        setupForgotPasswordButton()
        setupFBLoginButton()
        
        setupEmailImageView()
        setupPasswordImageView()
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
            ])
        
        //        addSubview(passwordTextField)
        //        passwordTextField.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.7)
        //        }
    }
    
    private func setupPasswordAddressLabel() {
        addSubview(passwordAddressLabel)
        passwordAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordAddressLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
            passwordAddressLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 8)
            ])
        
        //        addSubview(passwordAddressLabel)
        //        passwordAddressLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
        //            make.leading.equalTo(passwordTextField.snp.leading).offset(8)
        //        }
    }
    
    private func setupEmailAddressLabel() {
        addSubview(emailAddressLabel)
        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailAddressLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8),
            emailAddressLabel.leadingAnchor.constraint(equalTo: passwordAddressLabel.leadingAnchor)
            ])
        
        //        addSubview(emailAddressLabel)
        //        emailAddressLabel.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(passwordTextField.snp.top).offset(-8)
        //            make.leading.equalTo(passwordAddressLabel.snp.leading)
        //        }
    }
    
    private func setupEmailLoginTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLoginTextField.bottomAnchor.constraint(equalTo: emailAddressLabel.topAnchor, constant: -2),
            emailLoginTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            emailLoginTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)
            ])
        
        //        addSubview(emailLoginTextField)
        //        emailLoginTextField.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(emailAddressLabel.snp.top).offset(-2)
        //            make.leading.equalTo(passwordTextField.snp.leading)
        //            make.width.equalTo(passwordTextField.snp.width)
        //        }
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordAddressLabel.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
            ])
        
        //        addSubview(loginButton)
        //        loginButton.snp.makeConstraints { (make) in
        //            make.top.equalTo(passwordAddressLabel.snp.bottom).offset(10)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        //        }
    }
    
    private func setupForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 4),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor)
            ])
        
        //        addSubview(forgotPasswordButton)
        //        forgotPasswordButton.snp.makeConstraints { (make) in
        //            make.top.equalTo(loginButton.snp.bottom).offset(4)
        //            make.centerX.equalTo(loginButton.snp.centerX)
        //
        //        }
    }
    
    private func setupFBLoginButton() {
        addSubview(facebookLoginButton)
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            facebookLoginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            facebookLoginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
        
        //        addSubview(facebookLoginButton)
        //        facebookLoginButton.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-18)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //        }
    }
    
    
    
    private func setupEmailImageView() {
        addSubview(emailImageView)
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailImageView.centerYAnchor.constraint(equalTo: emailLoginTextField.centerYAnchor),
            emailImageView.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor, constant: 4),
            emailImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.08),
            emailImageView.heightAnchor.constraint(equalTo: emailImageView.widthAnchor)
            ])
    
    }
    
    
    private func setupPasswordImageView() {
        addSubview(passwordImageView)
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordImageView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 4),
            passwordImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.08),
            passwordImageView.heightAnchor.constraint(equalTo: passwordImageView.widthAnchor)
            ])
    }
    
}

