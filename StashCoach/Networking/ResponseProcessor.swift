//
//  ResponseProcessor.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// ResponseProcessor - responsible to converting a json response into a models
protocol ResponseProcessor {
    func processResponse(_ response: APIResponse<[String: Any]>)
}
