//
//  ChatViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    let chatView = ChatView()
    var specificEventIDsChat: String = ""
    let currentLoggedInUID = FirebaseAuthService.getCurrentUser()!.uid
    var lastIndexInData = 0
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
        chatView.tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
        // adds toolbar on top of textfied with done button to resing first responder
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        chatView.textView.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() -> Void {
        chatView.textView.resignFirstResponder()
    }
    
    private func setupView() {
        DatabaseService.manager.getChat(withEventID: specificEventIDsChat) { (data) in
            if let data = data {
                self.dummyData = data
//                if !self.dummyData.isEmpty {
//                    self.lastIndexInData = self.dummyData.count - 1
//                    let indexPath = IndexPath(item: self.lastIndexInData, section: 0)
//                    self.chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                }
            } else {
                print("No Data")
                // TODO: Empty State View
            }
        }
    }
    
    @objc private func sendMessage() {
        print(chatView.textView.text)
        let currentText = chatView.textView.text!
        DatabaseService.manager.addComment(eventID: specificEventIDsChat, userID: currentLoggedInUID, phoneNumber: "", email: "", text: currentText)
        setupView()
        chatView.textView.text = ""
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = dummyData.reversed()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
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
        textView.text = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
}
