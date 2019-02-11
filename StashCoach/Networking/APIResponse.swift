//
//  Result.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// APIResponse - either a successfully parsed response object, or an error
enum APIResponse<T> {
    case value(T)
    case error(Error)
}
