//
//  ChatView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ChatView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.allowsSelection = false
        tableView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical) //For the textview to expand based on the size of it's content, the tableview has to have a lower vertical hugging priority than the textview
        return tableView
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "Input message here"
        Stylesheet.Objects.Textviews.Editable.style(textview: textView)
        textView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical) // This tells the textview to be as big as its content
        textView.isScrollEnabled = false // The textview won't expand if it can scroll
        return textView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.backgroundColor = .green
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupTextView()
        setupSendButton()
        setupTableView()
    }
    
    private func setupTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        //textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 50).priority = UILayoutPriority(rawValue: 1) // The height constraint must have a priority lower than 1000 in order for the textview to resize itself. 
    }
    
    private func setupSendButton() {
        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
    }
    
}
