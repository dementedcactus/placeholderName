//
//  EmptyStateView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/28/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.Regular.style(label: label)
        label.font = UIFont(name: "Helvetica Neue", size: 30.0)
        label.textAlignment = .center
        return label
    }()
    
    init(emptyText: String) {
        super.init(frame: UIScreen.main.bounds)
        self.emptyLabel.text = emptyText
        commonInit()
    }
    
    init(frame: CGRect, emptyText: String) {
        super.init(frame: frame)
        self.emptyLabel.text = emptyText
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        self.addSubview(emptyLabel)
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        emptyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
}
