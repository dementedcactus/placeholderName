//
//  EventDetailView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventDetailView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "park")
        return imageView
    }()

    lazy var bannerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venuePlaceHolder")
        return imageView
    }()
    
    lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.PostTitle.style(label: label)
        return label
    }()
    
    lazy var eventTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Type"
        Stylesheet.Objects.Labels.PostCategory.style(label: label)
        return label
    }()
    
    lazy var rsvpButton: UIButton = {
        let button = UIButton()
        button.setTitle("RSVP", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
        return button
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        return datePicker
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("123 Fake Street", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
        return button
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Input message here"
        Stylesheet.Objects.Textviews.Completed.style(textview: textView)
        return textView
    }()
    
    lazy var goingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Going", for: .normal)
        button.backgroundColor = UIColor.blue
        //button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    lazy var notGoingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Not Going", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        // button.layer.cornerRadius = 10.0
        return button
    }()
    
    lazy var invitedButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Invited", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        //button.layer.cornerRadius = 10.0
        return button
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
        setupScrollView()
        setupContentView()
        setupBannerPhoto()
        setupEventTitle()
        setupEventTypeLabel()
        setupRsvpButton()
        setupDatePicker()
        setupMapView()
        setupLocationButton()
        setupDescriptionTextView()
        setupCollectionView()
        setupNotGoingButton()
        setupGoingButton()
        setupInvitedButton()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupBannerPhoto() {
        contentView.addSubview(bannerPhotoImageView)
        bannerPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bannerPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bannerPhotoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bannerPhotoImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        bannerPhotoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func setupEventTitle() {
        contentView.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventTitleLabel.topAnchor.constraint(equalTo: bannerPhotoImageView.bottomAnchor).isActive = true
        eventTitleLabel.heightAnchor.constraint(equalTo: bannerPhotoImageView.heightAnchor, multiplier: 0.2).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupEventTypeLabel() {
        contentView.addSubview(eventTypeLabel)
        eventTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventTypeLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor).isActive = true
        eventTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventTypeLabel.heightAnchor.constraint(equalTo: eventTitleLabel.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupRsvpButton() {
        contentView.addSubview(rsvpButton)
        rsvpButton.translatesAutoresizingMaskIntoConstraints = false
        rsvpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        rsvpButton.topAnchor.constraint(equalTo: eventTypeLabel.bottomAnchor, constant: 5).isActive = true
        rsvpButton.heightAnchor.constraint(equalTo: eventTitleLabel.heightAnchor, multiplier: 1).isActive = true
        rsvpButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    private func setupDatePicker() {
        contentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: rsvpButton.bottomAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    private func setupMapView() {
        contentView.addSubview(mapImageView)
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        mapImageView.leadingAnchor.constraint(equalTo: bannerPhotoImageView.leadingAnchor).isActive = true
        mapImageView.trailingAnchor.constraint(equalTo: bannerPhotoImageView.trailingAnchor).isActive = true
        mapImageView.topAnchor.constraint(equalTo: datePicker.bottomAnchor).isActive = true
        mapImageView.heightAnchor.constraint(equalTo: bannerPhotoImageView.heightAnchor).isActive = true
        
    }
    
    private func setupLocationButton() {
        contentView.addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        locationButton.topAnchor.constraint(equalTo: mapImageView.bottomAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        locationButton.heightAnchor.constraint(equalTo: rsvpButton.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupDescriptionTextView() {
        contentView.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalTo: bannerPhotoImageView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: bannerPhotoImageView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: bannerPhotoImageView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupNotGoingButton() {
        contentView.addSubview(notGoingButton)
        notGoingButton.translatesAutoresizingMaskIntoConstraints = false
        notGoingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        notGoingButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        notGoingButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true
        
    }
    
    private func setupGoingButton() {
        contentView.addSubview(goingButton)
        goingButton.translatesAutoresizingMaskIntoConstraints = false
        goingButton.leadingAnchor.constraint(equalTo: notGoingButton.trailingAnchor).isActive = true
        goingButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        goingButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.34).isActive = true
        
    }
    
    private func setupInvitedButton() {
        contentView.addSubview(invitedButton)
        invitedButton.translatesAutoresizingMaskIntoConstraints = false
        invitedButton.leadingAnchor.constraint(equalTo: goingButton.trailingAnchor).isActive = true
        invitedButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        invitedButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true
    }

    public func configureView(event: Event, eventImage: UIImage) {
        bannerPhotoImageView.image = eventImage
        eventTitleLabel.text = event.eventName
        locationButton.setTitle(event.eventLocation, for: .normal)
        descriptionTextView.text = event.eventDescription
    }

}
