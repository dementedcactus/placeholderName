//
//  WeekdaysView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class WeekdaysView: UIView {

    lazy var daysStackView: UIStackView = {
        let aWeekSV = UIStackView()
        aWeekSV.distribution = .fillEqually
        aWeekSV.translatesAutoresizingMaskIntoConstraints = false
        return aWeekSV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(daysStackView)
        daysStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        daysStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        daysStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        var daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
        for day in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[day]
            lbl.textAlignment = .center
            lbl.textColor = Style.weekdaysLabelColor
            daysStackView.addArrangedSubview(lbl) //This add the 'days' to the 'week'
        }
    }
    
}

