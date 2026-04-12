//
//  URL+PosterURL.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

extension String {
    func posterURL() -> URL? {
        return URL(string: "\(ServerConfig.shared.posterBaseUrl)\(self)")
    }
}
