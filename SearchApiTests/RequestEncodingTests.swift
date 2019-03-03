//
//  RequestEncodingTests.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import XCTest
@testable import SearchApi

class RequestEncodingTests: XCTestCase {
    
    func testItunesQueryUrlEncodingSpace() {
        // given
        let searchInput = "David Guetta"
        let expectedResult = "David+Guetta"
        
        // when
        let result = searchInput.addingPercentEncodingForFormData(plusForSpace: true)
        
        // then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testItunesRequestEncoding() {
        // given
        let searchInput = "David Guetta And His Friends"
        let request = ItunesSearchRequest(term: searchInput)
        let expectedResult = "https://itunes.apple.com/search?term=David+Guetta+And+His+Friends"
        
        // when
        let result = request.urlRequest
        
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.url?.absoluteString, expectedResult)
    }
    
    func testLasFmRequestEncoding() {
        // given
        let searchInput = "David Guetta"
        let page = 2
        let request = LastFmSearchRequest(track: searchInput, page: page)
        let expectedResult = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=David%20Guetta&api_key=6d7aec4d47d0d5aee8899cd6a7206145&format=json&page=2"
        
        // when
        let result = request.urlRequest
        
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.url?.absoluteString, expectedResult)
    }
}
