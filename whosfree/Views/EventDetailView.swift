//
//  EventDetailView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventDetailView: UIView {

    lazy var bannerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venuePlaceHolder")
        return imageView
    }()
    
    lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Title"
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventTypeCell")
        //tableView.backgroundColor = .blue
        return tableView
    }()
    
    lazy var rsvpButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("RSVP", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        return datePicker
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("123 Fake Street", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Input message here"
        textView.backgroundColor = .yellow
        return textView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "InvitedFriendsCollectionViewCell")
        return cv
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
        setupBannerPhoto()
        setupEventTitle()
        setupTableView()
        setupRsvpButton()
        setupDatePicker()
        setupLocationButton()
        setupDescriptionTextView()
        setupCollectionView()
    }
    
    private func setupBannerPhoto() {
        addSubview(bannerPhotoImageView)
        bannerPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerPhotoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        bannerPhotoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        bannerPhotoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        bannerPhotoImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupEventTitle() {
        addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventTitleLabel.topAnchor.constraint(equalTo: bannerPhotoImageView.bottomAnchor).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        eventTitleLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupRsvpButton() {
        addSubview(rsvpButton)
        rsvpButton.translatesAutoresizingMaskIntoConstraints = false
        rsvpButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        rsvpButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5).isActive = true
        rsvpButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    private func setupDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: rsvpButton.bottomAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    private func setupLocationButton() {
        addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        locationButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
    }


}
