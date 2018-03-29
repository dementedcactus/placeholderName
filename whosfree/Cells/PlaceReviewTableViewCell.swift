//
//  PlaceReviewTableViewCell.swift
//  whosfree
//
//  Created by Luis Calle on 3/28/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class PlaceReviewTableViewCell: UITableViewCell {
    
    lazy var starsReviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "zeroStars")
        return imageView
    }()
    
    lazy var reviewerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        return label
    }()
    
    lazy var reviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Review here"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "Review Cell")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        starsReviewImageView.clipsToBounds = true
    }
    
    private func setupViews() {
        setupReviewerNameLabel()
        setupStarsReviewImageView()
        setupReviewTextLabel()
    }
    
    private func setupReviewerNameLabel() {
        addSubview(reviewerNameLabel)
        reviewerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewerNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        //reviewerNameLabel.trailingAnchor.constraint(equalTo: starsReviewImageView.leadingAnchor).isActive = true
        reviewerNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setupStarsReviewImageView() {
        addSubview(starsReviewImageView)
        starsReviewImageView.translatesAutoresizingMaskIntoConstraints = false
        starsReviewImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        starsReviewImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        starsReviewImageView.heightAnchor.constraint(equalTo: starsReviewImageView.widthAnchor, multiplier: 0.25).isActive = true
        //starsReviewImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        starsReviewImageView.centerYAnchor.constraint(equalTo: reviewerNameLabel.centerYAnchor).isActive = true
    }
    
    private func setupReviewTextLabel() {
        addSubview(reviewTextLabel)
        reviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewTextLabel.topAnchor.constraint(equalTo: reviewerNameLabel.bottomAnchor, constant: 8).isActive = true
        reviewTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        reviewTextLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        reviewTextLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        reviewTextLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    public func configureCell(review: Review) {
        reviewerNameLabel.text = review.user.name
        reviewTextLabel.text = review.text
        switch review.rating {
        case 0:
            starsReviewImageView.image = #imageLiteral(resourceName: "zeroStars")
        case 1:
            starsReviewImageView.image = #imageLiteral(resourceName: "oneStar")
        case 2:
            starsReviewImageView.image = #imageLiteral(resourceName: "twoStars")
        case 3:
            starsReviewImageView.image = #imageLiteral(resourceName: "threeStars")
        case 4:
            starsReviewImageView.image = #imageLiteral(resourceName: "fourStars")
        case 5:
            starsReviewImageView.image = #imageLiteral(resourceName: "fiveStars")
        default:
            print("no rating rating available")
        }
    }
    
    
}

