//
//  SignInView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit

class SignInView: UIView {
    
    let signInContainerView = SignInContainerView()
    let signUpContainerView = SignUpContainerView()
    
    lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "wyd logo (original)")
        return imageView
    }()
    
    lazy var loginContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var createAccountContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
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
        backgroundColor = UIColor.groupTableViewBackground
        setupViews()
    }
    
    private func setupViews() {
        setupAppLogoImageView()
        setupLoginContainerButton()
        setupCreateAccountContainerButton()
        setupSignUpContainerView()
        setupSignInContainerView()
    }
    
    private func setupAppLogoImageView() {
        addSubview(appLogoImageView)
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            appLogoImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            appLogoImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            appLogoImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)
            ])
        
        //        addSubview(appLogoImageView)
        //        appLogoImageView.snp.makeConstraints { (make) in
        //            make.top.equalTo(safeAreaLayoutGuide).offset(16)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width)
        //        }
    }
    
    
    private func setupLoginContainerButton() {
        addSubview(loginContainerButton)
        loginContainerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginContainerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loginContainerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            loginContainerButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            ])
        
        //        addSubview(loginContainerButton)
        //        loginContainerButton.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        //            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
        //        }
    }
    
    private func setupCreateAccountContainerButton() {
        addSubview(createAccountContainerButton)
        createAccountContainerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountContainerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            createAccountContainerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            createAccountContainerButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
        
        //        addSubview(createAccountContainerButton)
        //        createAccountContainerButton.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        //        }
    }
    
    private func setupSignUpContainerView() {
        addSubview(signUpContainerView)
        signUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpContainerView.bottomAnchor.constraint(equalTo: loginContainerButton.topAnchor),
            signUpContainerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            signUpContainerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            signUpContainerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
            ])
        
        //        addSubview(signUpContainerView)
        //        signUpContainerView.snp.makeConstraints { (make) in
        //            make.bottom.equalTo(loginContainerButton.snp.top)
        //            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width)
        //            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.6)
        //        }
    }
    
    private func setupSignInContainerView() {
        addSubview(signInContainerView)
        signInContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInContainerView.topAnchor.constraint(equalTo: signUpContainerView.topAnchor),
            signInContainerView.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor),
            signInContainerView.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor),
            signInContainerView.bottomAnchor.constraint(equalTo: signUpContainerView.bottomAnchor),
            signInContainerView.centerXAnchor.constraint(equalTo: signUpContainerView.centerXAnchor),
            signInContainerView.centerYAnchor.constraint(equalTo: signUpContainerView.centerYAnchor)
            ])
        
        //        addSubview(signInContainerView)
        //        signInContainerView.snp.makeConstraints { (make) in
        //            make.edges.equalTo(signUpContainerView.snp.edges)
        //        }
    }
    
}

//class SignInView: UIView {
//
//    //signInButton
//    lazy var signinButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Sign In", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        backgroundColor = .blue
//        setupViews()
//    }
//
//    private func setupViews() {
//        setupObjects()
//        constrainObjects()
//    }
//
//    private func setupObjects() {
//        addSubview(signinButton)
//    }
//
//    private func constrainObjects() {
//
//        //ARRAY MUST BE IN ORDER!!
//        let signinViewObjects = [signinButton] as [UIView]
//
//        signinViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
//
//        NSLayoutConstraint.activate([
//
//            //profileButton
//            signinButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            signinButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
//            signinButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
//            signinButton.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
//
//            ])
//    }
//
//}

