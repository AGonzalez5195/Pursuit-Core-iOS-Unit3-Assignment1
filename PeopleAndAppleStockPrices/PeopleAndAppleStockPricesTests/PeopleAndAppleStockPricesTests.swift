//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Anthony Gonzalez on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

class PeopleAndAppleStockPricesTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDoesUserDataExist() { //Tests that data exists
        let data = getUserDataFromJSON()
        XCTAssertNotNil(data) //Stating, "I AM NOT NIL!!!"
    }
    
    func testDoesDataReturnUserResultsArray() { //Specifically tests if data gives back an array of userResults
        guard let data = getUserDataFromJSON() else { XCTFail(); return }
        do {
            let users = try usersModel.getUsers(from: data)
            XCTAssert(type(of: users) == [userResults].self, "You do not have a userResults object, idiot")
        } catch {
            fatalError()
        }
    }
    
    
    private func getUserDataFromJSON() -> Data? {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {return nil}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("\(jsonError)")
        }
    }
    
    func testGetsFullNameCapitalized(){
        let randomPersonName = userNameWrapper(first: "david", last: "rifkin")
        let randomPersonLocation = locationWrapper(street: "Elmo's World", city: "Harlem", state: "NY")
        let randomPersonPicture = pictureWrapper(large: "Embarassing Photo of David at the Christmas Party")
        let randomUser = userResults(name: randomPersonName, location: randomPersonLocation, phone: "phone", dob: "dob", picture: randomPersonPicture)
        
        let name = randomUser.getFullName()
        
        XCTAssert(name == "David Rifkin", "Function is not capitalizing properly")
    }
}

