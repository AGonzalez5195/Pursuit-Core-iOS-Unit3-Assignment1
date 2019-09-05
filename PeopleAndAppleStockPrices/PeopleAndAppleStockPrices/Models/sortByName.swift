//
//  sortByName.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

func sortByNameAscending(userArrayToSort: [userResults]) -> [userResults] {
    var sortedUsers = userArrayToSort
    sortedUsers = userArrayToSort.sorted(by: {$0.name.first < $1.name.first})
    return sortedUsers
}
