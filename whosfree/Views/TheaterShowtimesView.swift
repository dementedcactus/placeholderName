//
//  TheaterShowtimesView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit

class TheaterShowtimesView: UIView {
    
    lazy var showtimesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "showtime cell")
        return tableView
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
        setupShowtimesTableView()
    }
    
    private func setupShowtimesTableView() {
        addSubview(showtimesTableView)
        showtimesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showtimesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            showtimesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            showtimesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            showtimesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            showtimesTableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            showtimesTableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
        
        //        addSubview(showtimesTableView)
        //        showtimesTableView.snp.makeConstraints { (make) in
        //            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        //        }
    }
    
}

