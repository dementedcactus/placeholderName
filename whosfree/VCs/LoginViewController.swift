//
//  LoginVC.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/12/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
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
