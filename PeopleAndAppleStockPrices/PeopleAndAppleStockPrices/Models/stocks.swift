//
//  stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let openingPrice: Double
    let closingPrice: Double
    
    private enum CodingKeys: String, CodingKey {
        case date
        case openingPrice = "uOpen"
        case closingPrice = "uClose"
    }
    
    static func getStocks(from data: Data) throws -> [Stock] {
        do {
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            return stocks
        } catch {
            throw JSONError.decodingError(error)
        }
    }
    
    func getDateinDateFormat() -> Date {
        return self.date.toDate(dateFormat: "yyyy-MM-dd")!
    }
    
    
    
    static func trimDate(date: String) -> String {
        return String(date.dropLast(3))
    }
    
    static func groupStocksBySection(stockArr: [Stock]) -> [String: [Stock]] {
    
        var dictionary = [String: [Stock]]()
        
        for specificStock in stockArr {
            let key = Stock.trimDate(date: specificStock.date)
            if var stocks = dictionary[key] {
                //^ Value        ^Key
                stocks.append(specificStock) //When there is already an existing key, append the value to that already existing key/array.
                dictionary[key] = stocks //If not used, then the dates also in that month/year are not added to the dictionary.
            } else {
                dictionary[key] = [specificStock] //If a key doesn't exist, make it. 
            }
        }
         return dictionary
    }
}


