//
//  MovieHeaderView.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit
import Kingfisher

protocol MovieHeaderViewDelegate : class {
    func clickedBuyTicketButton(_ HeaderView: UIView, urlString: String)
}

class MovieHeaderView: UIView {
    
    weak var delegate: MovieHeaderViewDelegate?
    
    var urlStr: String!
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "movie title here"
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        //label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        //label.textAlignment = .center
        return label
    }()
    
    lazy var movieShortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "movie short description here"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating here"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var buyTicketsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy Tickets", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
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
        backgroundColor = UIColor.groupTableViewBackground
        buyTicketsButton.addTarget(self, action: #selector(clickedPurchaseTicket), for: .touchUpInside)
        setupViews()
    }
    
    @objc private func clickedPurchaseTicket() {
        delegate?.clickedBuyTicketButton(self, urlString: urlStr)
    }
    
    private func setupViews() {
        setupMovieImageView()
        setupMovieTitleLabel()
        setupMovieShortDescriptionLabel()
        setupMovieRatingLabel()
        setupBuyTicketsButton()
    }
    
    func setupMovieImageView() {
        addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        //        addSubview(movieImageView)
        //        movieImageView.snp.makeConstraints { (make) in
        //            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        //            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        //            make.width.equalTo(snp.width).multipliedBy(0.25)
        //            make.centerY.equalTo(snp.centerY)
        //        }
    }
    
    func setupMovieTitleLabel() {
        addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            ])
        
        //        addSubview(movieTitleLabel)
        //        movieTitleLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
        //            make.leading.equalTo(movieImageView.snp.trailing).offset(8)
        //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
        //        }
    }
    
    func setupMovieShortDescriptionLabel() {
        addSubview(movieShortDescriptionLabel)
        movieShortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieShortDescriptionLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            movieShortDescriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieShortDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
        
        //        addSubview(movieShortDescriptionLabel)
        //        movieShortDescriptionLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
        //            make.leading.equalTo(movieImageView.snp.trailing).offset(8)
        //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
        //        }
    }
    
    func setupMovieRatingLabel() {
        addSubview(movieRatingLabel)
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieRatingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieRatingLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
        
        //        addSubview(movieRatingLabel)
        //        movieRatingLabel.snp.makeConstraints { (make) in
        //            make.leading.equalTo(movieImageView.snp.trailing).offset(8)
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
        //        }
    }
    
    func setupBuyTicketsButton() {
        addSubview(buyTicketsButton)
        buyTicketsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyTicketsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buyTicketsButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            buyTicketsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4)
            ])
        
        //        addSubview(buyTicketsButton)
        //        buyTicketsButton.snp.makeConstraints { (make) in
        //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
        //            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-4)
        //        }
    }
    
    func configureHeader(imageURL: String, name: String, shortDescription: String, theURLString: String?, rating: String) {
        movieImageView.kf.indicatorType = .activity
        self.urlStr = theURLString
        movieTitleLabel.text = name
        movieShortDescriptionLabel.text = shortDescription
        movieRatingLabel.text = "Rated \(rating)"
        movieImageView.kf.setImage(with: URL(string: imageURL), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
        }
    }
    
}


