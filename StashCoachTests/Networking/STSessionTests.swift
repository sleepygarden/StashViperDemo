//
//  STSessionTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach

final class MockSTSession: STSession {
    
    enum MockError: Error {
        case error
    }
    
    func makeRequest(_ request: URLRequest, responseProcessor: ResponseProcessor) {
        responseProcessor.processResponse(.error(MockError.error))
    }
}

final class MockResponseProcessor: ResponseProcessor {
    var value: [String: Any]? = nil
    var error: Error? = nil
    
    func processResponse(_ response: APIResponse<[String: Any]>) {
        switch response {
        case .error(let error):
            self.error = error
        case .value(let value):
            self.value = value
        }
    }
    
    func reset() {
        value = nil
        error = nil
    }
}

final class STSessionTests: XCTestCase {
    
    enum TestError: Error {
        case error
    }

    static let validJSON = "{ \"hello\": \"world\"}"
    static let validJSONData = validJSON.data(using: .utf8)!
    static let xmlMimetype = "application/xml"
    static let jsonMimetype = "application/json"
    static let validURL = URL(string: "https://www.sleepy.nyc")!
    static let okayStatusCode = 200
    
    static let validResponse: URLResponse = HTTPURLResponse(url: validURL, mimeType: jsonMimetype, expectedContentLength: 0, textEncodingName: nil)
    
    func testDefaultResponseProcessingEmitsValue() {
        let mockSession = MockSTSession()
        let validJSONData = STSessionTests.validJSONData
        let validResponse = STSessionTests.validResponse
        let responseProcessor = MockResponseProcessor()
    
        mockSession.handleResponse(data: validJSONData, response: validResponse, error: nil, responseProcessor: responseProcessor)
        
        XCTAssertNotNil(responseProcessor.value, "Valid response should yield a value")
        XCTAssertNil(responseProcessor.error, "Valid response should not yield an error")
    }
    
    func testDefaultResponseProcessingForwardsNetworkErrors() {
        let mockSession = MockSTSession()
        let validJSONData = STSessionTests.validJSONData
        let validResponse = STSessionTests.validResponse
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: validJSONData, response: validResponse, error: TestError.error, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.apiError(let error) = apiError, case TestError.error = error else {
            XCTFail("Valid response should yield an error if passed in an error")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
    
    func testDefaultResponseProcessingOnlyAcceptsHTTP() {
        let mockSession = MockSTSession()
        let validJSONData = STSessionTests.validJSONData
        let nonHTTPResponse = URLResponse(url: STSessionTests.validURL, mimeType: STSessionTests.jsonMimetype, expectedContentLength: 0, textEncodingName: nil)
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: validJSONData, response: nonHTTPResponse, error: nil, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.notHTTPResponse = apiError else {
            XCTFail("Valid response should yield an error if the response isn't an HTTP response")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
    func testDefaultResponseProcessingOnlyAcceptsJSON() {
        let mockSession = MockSTSession()
        let validJSONData = STSessionTests.validJSONData
        let xmlResponse = HTTPURLResponse(url: STSessionTests.validURL, mimeType: STSessionTests.xmlMimetype, expectedContentLength: 0, textEncodingName: nil)
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: validJSONData, response: xmlResponse, error: nil, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.invalidMimetype(let mimetype) = apiError, mimetype == STSessionTests.xmlMimetype else {
            XCTFail("Valid response should yield an error if the response mimetype isn't JSON")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
    func testDefaultResponseProcessingErrorsOnNoResponsePayload() {
        let mockSession = MockSTSession()
        let validResponse = STSessionTests.validResponse
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: nil, response: validResponse, error: nil, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.emptyResponse = apiError else {
            XCTFail("Valid response should yield an error if the response payload is nil")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
    func testDefaultResponseProcessingErrorsOnMalformedJSON() {
        let mockSession = MockSTSession()
        let invalidJSON = "foobar[]baz".data(using: .utf8)!

        let validResponse = STSessionTests.validResponse
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: invalidJSON, response: validResponse, error: nil, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.malformedResponse(_) = apiError else {
            XCTFail("Valid response should yield an error if the response payload is not valid JSON")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
    func testDefaultResponseProcessingErrorsOnEmptyJSON() {
        let mockSession = MockSTSession()
        let validJSONNonObj = "[1,2]".data(using: .utf8)!
        
        let validResponse = STSessionTests.validResponse
        let responseProcessor = MockResponseProcessor()
        
        mockSession.handleResponse(data: validJSONNonObj, response: validResponse, error: nil, responseProcessor: responseProcessor)
        
        guard let apiError = responseProcessor.error, case APIError.responseNotJSONObj = apiError else {
            XCTFail("Valid response should yield an error if the response payload is JSON, but the root isn't an object")
            return
        }
        XCTAssertNil(responseProcessor.value, "Valid response should not yield a value when there is an error")
    }
    
}

