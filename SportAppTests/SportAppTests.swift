//
//  SportAppTests.swift
//  SportAppTests
//
//  Created by Thoraya Hamdy on 11/22/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import XCTest
@testable import SportApp

class SportAppTests: XCTestCase {

    let apiService = APIService()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadSportsFromAPI() {
        let expect = expectation(description: "Waiting for loading sports data")
        apiService.fetchDataFromAPI(url: Links.sports.rawValue, param: [:], responseClass: SportsResult.self) { (result, error) in
            if let _ = error {
                XCTFail()
            }
            else {
                XCTAssertTrue((result?.sports.count)! > 0, "Sports data not found")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testLoadLeaguesFromAPI() {
        let expect = expectation(description: "Waiting for loading leagues data")
        apiService.fetchDataFromAPI(url: Links.leagues.rawValue + "Soccer", param: [:], responseClass: LeaguesResult.self) { (result, error) in
            if let _ = error {
                XCTFail()
            }
            else {
                XCTAssertTrue((result?.countrys.count)! > 0, "Leagues data not found")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
