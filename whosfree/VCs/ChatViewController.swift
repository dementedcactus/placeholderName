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
    var dummyData = ["test1", "test2", "test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(chatView)
        self.chatView.tableView.delegate = self
        self.chatView.tableView.dataSource = self
        self.chatView.tableView.rowHeight = UITableViewAutomaticDimension
        self.chatView.textView.delegate = self
        self.chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    @objc private func sendMessage() {
        dummyData.append(chatView.textView.text)
        print(chatView.textView.text)
        let lastIndexInData = dummyData.count - 1
        let indexPath = IndexPath(item: lastIndexInData, section: 0)
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        chatView.tableView.reloadData()
    //    }
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        //TODO: Handle if userid == userid configureCell, else configureOtherUserCell
        if indexPath.row % 2 == 0 {
            cell.configureUserCell()
            return cell
        } else {
            cell.configureOtherUserCell()
            return cell
        }
        //return cell
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
