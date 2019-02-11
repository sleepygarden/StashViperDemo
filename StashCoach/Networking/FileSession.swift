//
//  FileSession.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

enum FileSessionError: Error {
    case invalidRequestURL
    case noSuchFile
    case fileNotJSON
    case unreadableFile

}

/// FileSession - an STSession that, Instead of reaching out to a network, instead tries to find a json file matching the path name of the request in the bundle - *this class is just meant for prototyping and testing*
final class FileSession: STSession {
    
    struct Constants {
        static let jsonExtensionType = "json"
    }
    
    private let bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func makeRequest(_ request: URLRequest, responseProcessor: ResponseProcessor) {
        guard let url = request.url else {
            handleResponse(data: nil, response: nil, error: FileSessionError.invalidRequestURL, responseProcessor: responseProcessor)
            return
        }
        
        switch readJSONFile(named: url.path) {
        case .error(let fileReadError):
            handleResponse(data: nil, response: nil, error: fileReadError, responseProcessor: responseProcessor)
        case .value(let jsonData):
            // mock an http response for for the handler
            let httpURLResponse = HTTPURLResponse(url: url, mimeType: ValidMimeTypes.json, expectedContentLength: 0, textEncodingName: nil)
            handleResponse(data: jsonData, response: httpURLResponse, error: nil, responseProcessor: responseProcessor)
        }
    }
    
    private func readJSONFile(named name: String) -> APIResponse<Data> {
        guard let url = bundle.url(forResource: name, withExtension: nil) else {
            return  .error(FileSessionError.noSuchFile)
        }
        
        // we only support json in the sample app
        if url.pathExtension != "json" {
            return .error(FileSessionError.fileNotJSON)
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return .error(FileSessionError.unreadableFile)
        }
        
        return .value(data)
    }
}
