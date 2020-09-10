//
//  TopicTableViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class TopicTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let data: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension TopicTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
