//
//  RequestBuilder.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// RequestBuilder - builds HTTP requests
struct RequestBuilder {
    
    struct Constants {
        static let GET = "GET"
    }
    
    private let apiRoot: URL
    
    init(root: String) {
        guard let apiRootURL = URL(string: root) else {
            fatalError("Developer provided an invalid API root URL")
        }
        self.apiRoot = apiRootURL
    }
    
    func get(_ path: String) -> URLRequest {
        let url = apiRoot.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = Constants.GET
        return request
    }
}
