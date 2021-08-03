//
//  ExtensionError.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 3/08/21.
//

import Foundation

extension ErrorsRequest {
    public var description: String {
        switch self {
        case .BAD_REQUEST:
            return "Expected 'q' text search parameter or other keywords."
        case .BAD_URL:
            return "This URL is not valid."
        }
    }
}
