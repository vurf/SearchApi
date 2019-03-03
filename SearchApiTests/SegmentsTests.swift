//
//  SegmentsTests.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import XCTest
@testable import SearchApi

class SegmentsTests: XCTestCase {
    
    var itunesSearchServiceMock: ItunesSearchServiceMock!
    var lastFmSearchServiceMock: LastFmSearchServiceMock!
    var viewModelFactoryMock: ViewModelFactoryMock!
    var factory: SegmentFactory!
    
    override func setUp() {
        itunesSearchServiceMock = ItunesSearchServiceMock()
        lastFmSearchServiceMock = LastFmSearchServiceMock()
        viewModelFactoryMock = ViewModelFactoryMock()
        factory = SegmentFactory(itunesSearchService: itunesSearchServiceMock,
                                 lastFmSearchService: lastFmSearchServiceMock,
                                 viewModelFactory: viewModelFactoryMock)
    }
    
    func testItunesSearch() {
        // given
        
        // when
        let segment = factory.getSegment(.iTunes)
        segment.search(with: "David")
        
        // then
        XCTAssertTrue(itunesSearchServiceMock.searchPerformIsCalled)
        XCTAssertFalse(lastFmSearchServiceMock.searchPerformIsCalled)
    }
    
    func testLastFmSearch() {
        // given
        
        // when
        let segment = factory.getSegment(.lastFm)
        segment.search(with: "David")
        
        // then
        XCTAssertFalse(itunesSearchServiceMock.searchPerformIsCalled)
        XCTAssertTrue(lastFmSearchServiceMock.searchPerformIsCalled)
        XCTAssertTrue(segment.currentPage == 0)
    }
}
