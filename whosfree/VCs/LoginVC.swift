//
//  LoginVC.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/12/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
