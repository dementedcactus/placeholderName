//
//  LoginVC.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/12/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    let loginView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
