//
//  CreateEventCell.swift
//  whosfree
//
//  Created by Lisa J on 3/23/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CreateEventCell: UITableViewCell {
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy var descripLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "  Event Title"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var eventTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Event Title"
        textField.textAlignment = .left
        return textField
    }()
    
    lazy var eventTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Event Type", for: .normal)
        button.backgroundColor = Stylesheet.Colors.azure
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(EventTypeTableViewCell.self, forCellReuseIdentifier: "EventTypeCell")
        tv.isHidden = true
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        return tv
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        return datePicker
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search For Location"
        return searchBar
    }()
    
    lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultsCell")
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var inviteFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("   Invite Friends", for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button.backgroundColor = Stylesheet.Colors.azure
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Event Description:"
        textView.layer.borderColor = Stylesheet.Colors.azure.cgColor
        textView.layer.borderWidth = 0.1
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "CreateEventCell")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        setupEventTitle()
        setupEventTypeButton()
        setupDatePicker()
        setupSearchBar()
        setupInviteButton()
        setupTableView()
        setupDescriptionTextView()
        setupSearchResultsTableView()
    }
    
    private func setupEventTitle() {
        addSubview(eventTitleTextField)
        eventTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        eventTitleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        eventTitleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        eventTitleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setupEventTypeButton() {
        addSubview(eventTypeButton)
        eventTypeButton.translatesAutoresizingMaskIntoConstraints = false
        eventTypeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant : 8).isActive = true
        eventTypeButton.topAnchor.constraint(equalTo: eventTitleTextField.bottomAnchor,  constant : 8 ).isActive = true
        eventTypeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,  constant : -8).isActive = true
        eventTypeButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: eventTypeButton.leadingAnchor,  constant : 8).isActive = true
        tableView.topAnchor.constraint(equalTo: eventTypeButton.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: eventTypeButton.trailingAnchor,  constant : 8).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: eventTypeButton.bottomAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: -5).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupInviteButton() {
        addSubview(inviteFriendsButton)
        inviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        inviteFriendsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant : 8).isActive = true
        inviteFriendsButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        inviteFriendsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant : -8).isActive = true
        inviteFriendsButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leadingAnchor.constraint(equalTo: inviteFriendsButton.leadingAnchor, constant : 8).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: inviteFriendsButton.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: inviteFriendsButton.trailingAnchor,constant: -8).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupDescripLine() {
        addSubview(descripLine)
        descripLine.translatesAutoresizingMaskIntoConstraints = false
        descripLine.topAnchor.constraint(equalTo: descriptionTextView.topAnchor,constant: -2).isActive = true
        descripLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        descripLine.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        descripLine.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.001).isActive = true
    }
    
    private func setupSearchResultsTableView() {
        addSubview(searchResultsTableView)
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchResultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchResultsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchResultsTableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
}
