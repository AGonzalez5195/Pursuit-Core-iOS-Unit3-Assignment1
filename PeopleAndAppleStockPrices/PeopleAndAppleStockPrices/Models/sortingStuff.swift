//
//  sortingStuff.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

func sortByNameAscending(userArrayToSort: [userResults]) -> [userResults] {
    var sortedUsers = userArrayToSort
    sortedUsers = userArrayToSort.sorted(by: {$0.getFullName() < $1.getFullName()})
    return sortedUsers
}


func getSortedArr(arr: [Stock]) -> [Stock] {
    return arr.sorted{ $0.getDateinDateFormat() < $1.getDateinDateFormat() }
}

func sortSections(arr: [String]) -> [String] {
    let sortedArr = arr.sorted{$0.toDate(dateFormat: "yyyy-MM")! < $1.toDate(dateFormat: "yyyy-MM")! }
    return sortedArr
}
