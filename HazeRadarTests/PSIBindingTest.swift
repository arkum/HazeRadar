//
//  PSIBindingTest.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import XCTest


@testable import HazeRadar


class PSIBindingTest: XCTestCase {
    
    var psi:PSI!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        psi = PSI()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        psi = nil
    }
    
    func testLoadOK(){
        let data = psi.load()
        XCTAssertTrue(data.central != nil)
        XCTAssertTrue(data.north != nil)
        XCTAssertTrue(data.south != nil)
        XCTAssertTrue(data.east != nil)
        XCTAssertTrue(data.west != nil)
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
