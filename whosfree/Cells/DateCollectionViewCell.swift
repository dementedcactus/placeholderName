//
//  DateCollectionViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Stylesheet.Colors.DarkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupViews()
    }
    
    private func setupViews() {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
