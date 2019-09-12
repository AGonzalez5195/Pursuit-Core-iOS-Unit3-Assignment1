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
    var groupedStocks: [String: [Stock]]!
    var sections: [String]!
    
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
            groupedStocks = Stock.buildGroupStocks(stocksFromJSON)
            sections = Array(groupedStocks.keys)
            sections = sortSections(arr: sections)

        } catch {fatalError("\(error)")}
    }
}

extension stocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sections[section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        return stocks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = sections[indexPath.section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        let currentStock = stocks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell")
        cell?.textLabel?.text = currentStock.date
        cell?.detailTextLabel?.text = "$\(currentStock.openingPrice)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionKey = sections[section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        
        return "\(sectionKey.changeDateFormatForHeader(dateFormat: "yyyy-MM"))                      Avg: $\(Stock.getMonthsAveragePrice(stockArr: stocks))"
        
    }
    
    
}
