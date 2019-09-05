//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class userViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [userResults]()
    
    var userSearchResults: [userResults] {
        get {
            guard let searchString = searchString else { return users }
            guard searchString != ""  else { return users }
            return userResults.getFilteredUsers(arr: users, searchString: searchString)
        }
    }
    
    var searchString: String? = nil { didSet { self.tableView.reloadData()} }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
        case "segueToDetail":
            guard let destVC = segue.destination as? detailUserViewController else { fatalError("Unexpected segue VC") }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
            let currentUser = userSearchResults[selectedIndexPath.row]
            destVC.currentUser = currentUser
        default:
            fatalError("unexpected segue identifier")
        }
    }
    
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let usersFromJSON = try usersModel.getUsers(from: data)
            users = usersFromJSON
            users = sortByNameAscending(userArrayToSort: users)
        } catch {fatalError("\(error)")}
    }
    
    private func configureDelegateDataSources(){
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureDelegateDataSources()
    }
}



extension userViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = userSearchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        cell?.textLabel?.text = "\(currentUser.getFullName())"
        cell?.detailTextLabel?.text = "\(currentUser.getLocation())"
        return cell!
    }
}

extension userViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
