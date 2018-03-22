
//
//  TheaterTableViewCell.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
//import SnapKit

// TODO: Try cell with image on top just a little and labels in bottom and no snapkit
class TheaterTableViewCell: UITableViewCell {
    
    lazy var theaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "theaterImagePlaceholder")
        return imageView
    }()
    
    lazy var theaterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Theater Name here"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var theaterAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Theater Address here"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "TheaterTableViewCell")
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
        theaterImageView.clipsToBounds = true
    }
    
    private func setupViews() {
        setupTheaterImageView()
        setupTheaterNameLabel()
        setupTheaterAddressLabel()
    }
    
    //    private func setupTheaterImageView() {
    //        addSubview(theaterImageView)
    //        theaterImageView.snp.makeConstraints { (make) in
    //            make.top.equalTo(safeAreaLayoutGuide.snp.top)
    //            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
    //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
    //            make.height.equalTo(snp.height).multipliedBy(0.3)
    //            make.width.equalTo(safeAreaLayoutGuide.snp.width)
    //        }
    //    }
    //
    //    private func setupTheaterNameLabel() {
    //        addSubview(theaterNameLabel)
    //        theaterNameLabel.snp.makeConstraints { (make) in
    //            make.top.equalTo(theaterImageView.snp.bottom).offset(8)
    //            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
    //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
    //        }
    //    }
    //
    //    private func setupTheaterAddressLabel() {
    //        addSubview(theaterAddressLabel)
    //
    //        theaterAddressLabel.snp.makeConstraints { (make) in
    //            make.top.equalTo(theaterNameLabel.snp.bottom).offset(8)
    //            make.leading.equalTo(theaterImageView.snp.leading).offset(8)
    //            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
    //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    //        }
    //    }
    
    
    private func setupTheaterImageView() {
        addSubview(theaterImageView)
        theaterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            theaterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            theaterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            theaterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            theaterImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            theaterImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
//        addSubview(theaterImageView)
//        theaterImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top)
//            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
//            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
//            make.width.equalTo(snp.width).multipliedBy(0.3)
//            make.centerY.equalTo(snp.centerY)
//        }
    }
    
    private func setupTheaterNameLabel() {
        addSubview(theaterNameLabel)
        theaterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            theaterNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            theaterNameLabel.leadingAnchor.constraint(equalTo: theaterImageView.trailingAnchor, constant: 8),
            theaterNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
//        addSubview(theaterNameLabel)
//        theaterNameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
//            make.leading.equalTo(theaterImageView.snp.trailing).offset(8)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
//        }
    }
    
    private func setupTheaterAddressLabel() {
        addSubview(theaterAddressLabel)
        theaterAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            theaterAddressLabel.topAnchor.constraint(equalTo: theaterNameLabel.bottomAnchor, constant: 8),
            theaterAddressLabel.leadingAnchor.constraint(equalTo: theaterImageView.trailingAnchor, constant: 8),
            theaterAddressLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
//        addSubview(theaterAddressLabel)
//        theaterAddressLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(theaterNameLabel.snp.bottom).offset(8)
//            make.leading.equalTo(theaterImageView.snp.trailing).offset(8)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
//        }
    }
    
    public func configureCell(theater: Theater) {
        theaterNameLabel.text = theater.name
        theaterAddressLabel.text = theater.location.address.street + ", " + theater.location.address.city + ", " + theater.location.address.state
    }
    
}
