//
//  RequestBuilderTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach

class RequestBuilderTests: XCTestCase {
    
    func testBuildsGETs() {
        let builder = RequestBuilder(root: "https://www.sleepy.com")
        let req = builder.get("foo.json")
        XCTAssertEqual(req.httpMethod, "GET")
        XCTAssertEqual(req.url?.absoluteString, "https://www.sleepy.com/foo.json")
    }
    
}
