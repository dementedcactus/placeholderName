//
//  LoginView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/12/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class SignInView: UIView {

    //signInButton
    lazy var signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
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
        backgroundColor = .blue
        setupViews()
    }
    
    private func setupViews() {
        setupObjects()
        constrainObjects()
    }
    
    private func setupObjects() {
        addSubview(signinButton)
    }
    
    private func constrainObjects() {
        
        //ARRAY MUST BE IN ORDER!!
        let signinViewObjects = [signinButton] as [UIView]
        
        signinViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //profileButton
            signinButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            signinButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            signinButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            signinButton.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)

            ])
    }

}
