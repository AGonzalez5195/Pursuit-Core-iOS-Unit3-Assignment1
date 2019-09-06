//
//  Extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateFormatInString(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    func changeDateFormatForHeader(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/yyyy"
        return formatter.string(from: date)
    }
}

extension Date {
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
}

