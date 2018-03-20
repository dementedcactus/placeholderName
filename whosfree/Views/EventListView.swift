//
//  EventListView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventListView: UIView {

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuImage"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
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
        backgroundColor = .brown
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(plusButton)
        
        //ARRAY MUST BE IN ORDER!!
        let EventListObjects = [tableView, plusButton] as [UIView]
        
        EventListObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //tableview
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            //calendarButton
            //plusButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 1.0),
            //plusButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 1.0),
            plusButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            plusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            plusButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.12),
            plusButton.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.12)
            ])
        
    }
    
}

