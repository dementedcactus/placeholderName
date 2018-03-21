//
//  CalendarViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    public var theme = Stylesheet.MyTheme.Dark
    lazy var calenderView: CalenderView = {
        let cv = CalenderView(theme: Stylesheet.MyTheme.Dark)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(leftBarButtonAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        setupViews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.monthCollectionView.collectionViewLayout.invalidateLayout()
    }
    private func setupViews() {
        view.addSubview(calenderView)
        self.view.backgroundColor = Style.backgroundColor
        calenderView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        calenderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        calenderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        calenderView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
    }
    @objc func rightBarButtonAction(sender: UIBarButtonItem) {
        if theme == .Dark {
            sender.title = "Dark"
            theme = .Light
            Style.lightTheme()
        } else {
            sender.title = "Light"
            theme = .Dark
            Style.darkTheme()
        }
        self.view.backgroundColor = Style.backgroundColor
        calenderView.changeTheme()
    }
    @objc func leftBarButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
}

