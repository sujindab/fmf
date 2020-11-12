//
//  contentViewController.swift
//  findmyfriend
//
//  Created by BIG on 12/11/2563 BE.
//

import UIKit

class contentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    let data = [
        "adam",
        "eva"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.delegate = self
        myTableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
        
    }

}
