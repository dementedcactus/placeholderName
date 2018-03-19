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
        //no separator lines on tableview
        self.chatView.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    @objc private func sendMessage() {
        dummyData.append(chatView.textView.text)
        print(chatView.textView.text)
        chatView.tableView.reloadData()
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
        } else {
            cell.configureOtherUserCell()
        }
        return cell
    }
}
