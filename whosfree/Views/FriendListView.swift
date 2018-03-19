//
//  FriendListView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class FriendListView: UIView {

    //searchBar
    lazy var friendSearchbBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a Friend"
        return searchBar
    }()
    
    //tableview
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendCell")
        tv.backgroundColor = .clear
        return tv
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
        backgroundColor = .yellow
        setupViews()
    }
    
    private func setupViews() {
        addSubview(friendSearchbBar)
        addSubview(tableView)
        
        //ARRAY MUST BE IN ORDER!!
        let FriendListObjects = [friendSearchbBar,tableView] as [UIView]
        
        FriendListObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //searchbar
            friendSearchbBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            friendSearchbBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            friendSearchbBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            //tableview
            tableView.topAnchor.constraint(equalTo: self.friendSearchbBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
}

