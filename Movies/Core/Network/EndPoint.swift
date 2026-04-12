//
//  EndPoint.swift
//  Event
//
//  Created by Madney on 12/04/2026.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    var paramter: [String: Any]? { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }

    var request: URLRequest {
        let url = URL(string: base + path)!
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = header
        if let paramter = paramter {
            request.httpBody = try! JSONSerialization.data(withJSONObject: paramter)
        }
        return request
    }
    
    var header : [String: String]? {
        return ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMDU1ZGUxYmYwM2U5ZGRkM2ZkMDczOTdhYTAzNWNlMCIsIm5iZiI6MTc3NjAxMjY3MC4xOTEsInN1YiI6IjY5ZGJjZDdlMjVjODg5MmI4YzliODBlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TXa-MNjkRIAEAN4gPWb1qy5FPlJpW6wyOPICwizn0Gk"]
    }
}
