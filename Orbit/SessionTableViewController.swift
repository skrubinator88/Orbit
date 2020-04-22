//
//  SessionTableViewController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController{

    var sessions:[Session] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SessionTableViewCell.self, forCellReuseIdentifier: "sessionCell")
        self.tableView.tableFooterView = UIView()
        let plusBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addActivityButtonPressed))
        navigationItem.rightBarButtonItem = plusBarButtonItem
        navigationItem.title = "Activities"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sessions = Session.getSessions() ?? []
        tableView.reloadData()
    }
    
    @objc func addActivityButtonPressed() {
        let addActivityViewController = AddActivityViewController()
        self.show(addActivityViewController, sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sessions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(75)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.session = sessions[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sessionViewController = SessionViewController()
        sessionViewController.session = sessions[indexPath.item]
        show(sessionViewController, sender: self)
    }

}
