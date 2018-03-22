//
//  EventTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear
        return cv
    }()
    
    //eventTitleLabel
    lazy var eventTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Event Title"
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 17)
        lb.numberOfLines = 0
        lb.backgroundColor = .clear
        return lb
    }()
    
    //eventDateAndTimeLabel
    lazy var eventDateAndTimeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "eventDate eventTime"
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 17)
        lb.numberOfLines = 0
        lb.backgroundColor = .clear
        return lb
    }()
    
    //eventBannerPhotoImageView
    lazy var eventBannerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "park")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //placeholderIconImageView
    lazy var placeholderIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "EventCell")
        setupAndConstrainObjects()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
    }
    private func setupAndConstrainObjects(){
        contentView.addSubview(containerView)
        containerView.addSubview(eventBannerPhotoImageView)
        containerView.addSubview(eventTitleLabel)
        containerView.addSubview(placeholderIconImageView)
        containerView.addSubview(eventDateAndTimeLabel)
        
        //ARRAY MUST BE IN ORDER!!
        let eventCellObjects = [containerView, eventBannerPhotoImageView, eventTitleLabel, placeholderIconImageView, eventDateAndTimeLabel] as [UIView]
        
        eventCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //containerView
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //containerView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            //eventBannerPhotoImageView
            eventBannerPhotoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            eventBannerPhotoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            eventBannerPhotoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            eventBannerPhotoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            //eventTitleLabel
            eventTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            eventTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            //placeholderIconImageView
            placeholderIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            placeholderIconImageView.bottomAnchor.constraint(equalTo: eventTitleLabel.topAnchor),
            placeholderIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            placeholderIconImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),

            //eventDateAndTimeLabel
            eventDateAndTimeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            eventDateAndTimeLabel.bottomAnchor.constraint(equalTo: eventTitleLabel.topAnchor),
            eventDateAndTimeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            eventDateAndTimeLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25)
            ])
        
    }
    
}

