//
//  RetroTraderTests.swift
//  RetroTraderTests
//
//  Created by Gary Naz on 12/19/20.
//

import XCTest

class RetroTraderTests: XCTestCase {

    func testHelloWorld(){
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        
        XCTAssertEqual(helloWorld, "hello world")
    }

}
