//
//  EventTypeTableViewCell.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventTypeTableViewCell: UITableViewCell {

    //label
    lazy var eventTypeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Here"
        Stylesheet.Objects.Labels.Regular.style(label: lb)
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "EventTypeCell")
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
        addSubview(eventTypeLabel)
        eventTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        eventTypeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        eventTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        eventTypeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
