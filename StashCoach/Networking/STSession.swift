//
//  STSession.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// STSession - A mockable session to submit networking requests to
protocol STSession {
    
    /// Begin a networking call. Implementers must call handleResponse with the results of the request
    func makeRequest(_ request: URLRequest, responseProcessor: ResponseProcessor)
    
    /// Parse the response and pass into the ResponseProcessor
    func handleResponse(data: Data?, response: URLResponse?, error: Error?, responseProcessor: ResponseProcessor)

}

enum APIError: Error {
    case apiError(Error)
    case notHTTPResponse
    case invalidMimetype(String?)
    case emptyResponse
    case malformedResponse(Error)
    case responseNotJSONObj
}

struct ValidMimeTypes {
    static let json = "application/json"
}

/// Default response parsing that may be shared by all STSessions
extension STSession {
    
    func handleResponse(data: Data?, response: URLResponse?, error: Error?, responseProcessor: ResponseProcessor) {
        if let error = error {
            responseProcessor.processResponse(.error(APIError.apiError(error)))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            responseProcessor.processResponse(.error(APIError.notHTTPResponse))
            return
        }
        
        // we only support JSON in the sample app
        if httpResponse.mimeType != ValidMimeTypes.json {
            responseProcessor.processResponse(.error(APIError.invalidMimetype(httpResponse.mimeType)))
            return
        }
        
        guard let data = data else {
            responseProcessor.processResponse(.error(APIError.emptyResponse))
            return
        }
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            // we only support top level dicts in the sample app
            guard let jsonDict = jsonObj as? [String: Any] else {
                responseProcessor.processResponse(.error(APIError.responseNotJSONObj))
                return
            }
            
            responseProcessor.processResponse(.value(jsonDict))
        }
        catch let parseError {
            responseProcessor.processResponse(.error(APIError.malformedResponse(parseError)))
            return
        }        
    }
}

