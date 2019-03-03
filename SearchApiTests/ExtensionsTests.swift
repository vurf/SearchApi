//
//  ExtensionsTests.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import XCTest
@testable import SearchApi

class ExtensionsTests: XCTestCase {
    
    func testClassName() {
        // given
        let classType = NSString.self
        let expectedResult = "NSString"
        
        // when
        let result = classType.className
        
        // then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testClassNameForTableViewCell() {
        // given
        let expectedResult = "LastFmTableViewCell"
        
        // when
        let result = LastFmTableViewCell.className
        
        // then
        XCTAssertEqual(result, expectedResult)
    }

}
