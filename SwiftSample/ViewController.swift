//
//  ViewController.swift
//  SwiftSample
//
//  Created by Julian Gruber on 13/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

import UIKit
import TwitterSearchKit

class ViewController: UITableViewController {

    let reuseIdentifier:String = "reuseIdentifier"
    
    var tweets:[[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sample App"
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.reuseIdentifier)
        
        TwitterSearchKit.getTweets(withSearchTerm: "Radiohead") { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
     
        // Configure the cell...
        if let tweet = self.tweets?[indexPath.row], let text = tweet["text"] as? String {
            cell.textLabel?.text = text
        } else {
            cell.textLabel?.text = "Tweet unavailable"
        }
     
        return cell
    }
    
}

