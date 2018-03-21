//
//  MonthView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthView: UIView {
    private var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    private var currentMonthIndex = 0
    private var currentYear: Int = 0
    public var monthToDisplayDelegate: MonthViewDelegate?
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Default Month Year text"
        lbl.textColor = Style.monthViewLabelColor
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(Style.monthViewRightButtonColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftButtonRightButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var leftButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(Style.monthviewLeftButtonColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftButtonRightButtonAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        setupViews()
        leftButton.isEnabled = false
    }
    
    @objc func leftButtonRightButtonAction(sender: UIButton) {
        if sender == rightButton {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        nameLabel.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
        monthToDisplayDelegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    private func setupViews() {
        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        nameLabel.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
        
        self.addSubview(rightButton)
        rightButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(leftButton)
        leftButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
}


