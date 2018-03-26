//
//  ChatViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let chatView = ChatView()
    var specificEventIDsChat: String = ""
    let currentLoggedInUID = FirebaseAuthService.getCurrentUser()!.uid
    var dummyData = [Comment]() {
        didSet {
            chatView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(chatView)
        self.chatView.tableView.delegate = self
        self.chatView.tableView.dataSource = self
        self.chatView.tableView.rowHeight = UITableViewAutomaticDimension
        self.chatView.textView.delegate = self
        self.chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        setupView()
    }
    
    private func setupView() {
        var lastIndexInData = 0
        DatabaseService.manager.getChat(withEventID: specificEventIDsChat) { (data) in
            if let data = data {
                self.dummyData = data
            } else {
                print("No Data")
                // TODO: Empty State View
            }
        }
        if !dummyData.isEmpty {
            lastIndexInData = dummyData.count - 1
            let indexPath = IndexPath(item: lastIndexInData, section: 0)
            chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc private func sendMessage() {
        print(chatView.textView.text)
        let currentText = chatView.textView.text!
        DatabaseService.manager.addComment(eventID: specificEventIDsChat, userID: currentLoggedInUID, phoneNumber: "", email: "", text: currentText)
        setupView()
    }
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        if comment.userID == currentLoggedInUID {
            cell.configureUserCell(comment: comment)
            return cell
        } else {
            cell.configureOtherUserCell(comment: comment)
            return cell
        }
    }
    
}
extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        becomeFirstResponder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
}
