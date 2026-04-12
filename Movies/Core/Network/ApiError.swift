//
//  APIErrors.swift
//  Event
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct ServerErrorResponse: Decodable {
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

enum ApiError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet

    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .requestFailed(description):
            return description
        case .invalidData:
            return "Invalid data."
        case let .responseUnsuccessful(description):
            return description
        case let .jsonConversionFailure(description):
            return description
        case .jsonParsingFailure:
            return "JSON parsing failure."
        case .failedSerialization:
            return "Serialization failed."
        case .noInternet:
            return "No internet connection."
        }
    }
}
