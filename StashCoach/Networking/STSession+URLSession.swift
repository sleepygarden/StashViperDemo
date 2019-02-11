//
//  NetworkSession+URLSession.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// URLSession + STSession conformance
extension URLSession: STSession {    
    func makeRequest(_ request: URLRequest, responseProcessor: ResponseProcessor) {
        dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            self?.handleResponse(data: data, response: response, error: error, responseProcessor: responseProcessor)
        }.resume()
    }
}
