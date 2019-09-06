//
//  stocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stocksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var stocks = [Stock]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
        case "segueToDetail":
            guard let destVC = segue.destination as? detailStocksViewController else { fatalError("Unexpected segue VC") }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
            let currentStock = stocks[selectedIndexPath.row]
            destVC.currentStock = currentStock
        default:
            fatalError("unexpected segue identifier")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData() 
    }
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let stocksFromJSON = try Stock.getStocks(from: data)
            stocks = stocksFromJSON

        } catch {fatalError("\(error)")}
    }
}

extension stocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell")
        let currentStock = stocks[indexPath.row]
        cell?.textLabel?.text = currentStock.date
        cell?.detailTextLabel?.text = currentStock.openingPrice.description
        return cell!
    }
    
    
}
