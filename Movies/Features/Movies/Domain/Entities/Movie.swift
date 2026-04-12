//
//  Movie.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let poster: String?
    let genreIds: [Int]
}
