//
//  CreateEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    let createEventView = CreateEventView()
    var dummyData = ["test1 title", "test2 title", "test3 title"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(createEventView)
        self.createEventView.tableView.dataSource = self
        self.createEventView.tableView.delegate = self
    }
    
}
extension CreateEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath)
        cell.textLabel?.text = data
        return cell
    }
    

}
