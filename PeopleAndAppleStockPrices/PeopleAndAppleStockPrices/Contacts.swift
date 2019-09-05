//
//  Contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case decodingError(Error)
}

struct usersModel: Codable {
    let results: [userResults]
    
    static func getUsers(from data: Data) throws -> [userResults] {
        do {
            let users = try JSONDecoder().decode(usersModel.self, from: data)
            return users.results
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}

struct userResults: Codable {
    let name: userNameWrapper
    let location: locationWrapper
    let phone: String
    var dob: String
    let picture: pictureWrapper
    
    
    func getFullName() -> String {
        let firstName = name.first.capitalized
        let lastName = name.last.capitalized
        
        return "\(firstName) \(lastName)"
    }
    
    func getLocation() -> String {
        let street = location.street.capitalized
        let city = location.city.capitalized
        let state = location.state.capitalized
        
        return "\(street), \(city), \(state)"
    }
    
    static func getFilteredUsers(arr: [userResults], searchString: String) -> [userResults] {
        return arr.filter{$0.getFullName().lowercased().contains(searchString.lowercased())}
    }
}

struct userNameWrapper: Codable {
    let first: String
    let last: String
    
}

struct locationWrapper: Codable {
    let street: String
    let city: String
    let state: String
}

struct dobWrapper: Codable {
    var date: String
}

struct pictureWrapper: Codable {
    let large: String
}
