//
//  NetworkApi.swift
//  Event
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol NetworkApi {
    var session: URLSession { get }
    func fetch<T: Decodable>(type: T.Type, with request: Endpoint) async throws -> T
}

extension NetworkApi {
    func fetch<T: Decodable>(type: T.Type, with request: Endpoint) async throws -> T {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request.request)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw ApiError.noInternet
        } catch {
            throw ApiError.requestFailed(description: error.localizedDescription)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Invalid response")
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            let serverMessage = decodeServerErrorMessage(from: data)
            let description = serverMessage ?? "Status code: \(httpResponse.statusCode)"
            throw ApiError.responseUnsuccessful(description: description)
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }

    private func decodeServerErrorMessage(from data: Data) -> String? {
        guard let serverError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) else {
            return nil
        }
        return serverError.statusMessage
    }
}
