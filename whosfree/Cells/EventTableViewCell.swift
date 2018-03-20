//
//  EventTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

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
        addSubview(eventBannerPhotoImageView)
        addSubview(eventTitleLabel)
        addSubview(placeholderIconImageView)
        addSubview(eventDateAndTimeLabel)
        
        //ARRAY MUST BE IN ORDER!!
        let eventCellObjects = [eventBannerPhotoImageView, eventTitleLabel, placeholderIconImageView, eventDateAndTimeLabel] as [UIView]
        
        eventCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //eventBannerPhotoImageView
            //eventBannerPhotoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            eventBannerPhotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            eventBannerPhotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            eventBannerPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            eventBannerPhotoImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            eventBannerPhotoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            //eventTitleLabel
            eventTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            eventTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            eventTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            //placeholderIconImageView
            placeholderIconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderIconImageView.bottomAnchor.constraint(equalTo: eventTitleLabel.topAnchor),
            placeholderIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderIconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            //eventDateAndTimeLabel
            eventDateAndTimeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            eventDateAndTimeLabel.bottomAnchor.constraint(equalTo: eventTitleLabel.topAnchor),
            eventDateAndTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            eventDateAndTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
            ])
        
    }
    
}

