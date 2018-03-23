//
//  CreateEventView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CreateEventView: UIView {

    lazy var bannerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venuePlaceHolder")
        return imageView
    }()
    
    lazy var pageTableView: UITableView = {
        let tv = UITableView()
        tv.register(CreateEventCell.self, forCellReuseIdentifier: "CreateEventCell")
        tv.allowsSelection = false
        //tv.backgroundColor = .clear
        //tv.separatorColor = .clear
        return tv
    }()
    
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
        label.text = "Event Title"
        label.textAlignment = .left
        return label
    }()
    
    lazy var eventTitleTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Event Title"
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var eventTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Event Type", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
//        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
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
        //tableView.backgroundColor = .blue
        return tableView
    }()
    
    lazy var inviteFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("   Invite Friends", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setImage(#imageLiteral(resourceName: "chatBubble"), for: .normal)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //button.backgroundColor = UIColor.blue
        //button.layer.cornerRadius = 10.0
        return button
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "   Event Description:"
        //textView.backgroundColor = .yellow
        return textView
    }()
    
//    lazy var createEventButton: UIButton = {
//        let button = UIButton()
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.setTitle("   Create Event", for: .normal)
//        button.setImage(#imageLiteral(resourceName: "chatBubble"), for: .normal)
//        button.layer.borderColor = UIColor.white.cgColor
//        //button.backgroundColor = UIColor.blue
//        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
//        //button.layer.cornerRadius = 10.0
//        return button
//    }()
    
    
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
        setupBannerPhoto()
        setupPageTableView()
        //setupEventTitle()
        //setupCreateEvent()
       // setupCreateLine()
//        setupDescriptionTextView()
//        setupDescripLine()
//        setupInviteButton()
//        setupSearchBar()
//        setupDatePicker()
//        setupEventTypeButton()
//        setupTableView()
//        setupSearchResultsTableView()
    }
    
    private func setupBannerPhoto() {
        addSubview(bannerPhotoImageView)
        bannerPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerPhotoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        bannerPhotoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        bannerPhotoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        bannerPhotoImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupPageTableView() {
        addSubview(pageTableView)
        pageTableView.translatesAutoresizingMaskIntoConstraints = false
        pageTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        pageTableView.topAnchor.constraint(equalTo: bannerPhotoImageView.bottomAnchor).isActive = true
        pageTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        pageTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
//    private func setupEventTitle() {
//        addSubview(eventTitleLabel)
//        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        eventTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        eventTitleLabel.topAnchor.constraint(equalTo: bannerPhotoImageView.bottomAnchor).isActive = true
//        eventTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//    }
    
    private func setupEventTitle() {
        addSubview(eventTitleTextField)
        eventTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        eventTitleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventTitleTextField.topAnchor.constraint(equalTo: bannerPhotoImageView.bottomAnchor).isActive = true
        eventTitleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
//    private func setupCreateLine() {
//        addSubview(line)
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.topAnchor.constraint(equalTo: createEventButton.topAnchor,constant: -2).isActive = true
//        line.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        line.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        line.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.002).isActive = true
//    }
    
    private func setupEventTypeButton() {
        addSubview(eventTypeButton)
        eventTypeButton.translatesAutoresizingMaskIntoConstraints = false
        eventTypeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventTypeButton.topAnchor.constraint(equalTo: eventTitleTextField.bottomAnchor).isActive = true
        eventTypeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        eventTypeButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: eventTypeButton.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: eventTypeButton.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: eventTypeButton.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: inviteFriendsButton.topAnchor, constant: -5).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupInviteButton() {
        addSubview(inviteFriendsButton)
        inviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        inviteFriendsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        inviteFriendsButton.bottomAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: -5).isActive = true
        inviteFriendsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        inviteFriendsButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupDescripLine() {
        addSubview(descripLine)
        descripLine.translatesAutoresizingMaskIntoConstraints = false
        descripLine.topAnchor.constraint(equalTo: descriptionTextView.topAnchor,constant: -2).isActive = true
        descripLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        descripLine.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        descripLine.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.001).isActive = true
    }
    
//    private func setupCreateEvent() {
//        addSubview(createEventButton)
//        createEventButton.translatesAutoresizingMaskIntoConstraints = false
//        createEventButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        //createEventButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5).isActive = true
//        createEventButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        createEventButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -2).isActive = true
//        createEventButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
//    }
    
    private func setupSearchResultsTableView() {
        addSubview(searchResultsTableView)
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchResultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchResultsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchResultsTableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }


}
