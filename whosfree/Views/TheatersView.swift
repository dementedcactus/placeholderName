//
//  TheatersView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit

class TheatersView: UIView {
    
    lazy var theaterSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var theatersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TheaterTableViewCell.self, forCellReuseIdentifier: "TheaterTableViewCell")
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
        //       setupTheatersSearchBar()
        setupTheatersTableView()
    }
    
    //    private func setupTheatersSearchBar() {
    //        addSubview(theaterSearchBar)
    //        theaterSearchBar.snp.makeConstraints { (make) in
    //            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
    //        }
    //    }
    
    private func setupTheatersTableView() {
        addSubview(theatersTableView)
        theatersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            theatersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            theatersTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            theatersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            theatersTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            theatersTableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            theatersTableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
        
        //        addSubview(theatersTableView)
        //        theatersTableView.snp.makeConstraints { (make) in
        ////            make.top.equalTo(theaterSearchBar.snp.bottom)
        ////            make.leading.bottom.trailing.equalTo(safeAreaLayoutGuide)
        //            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        //        }
    }
    
}

