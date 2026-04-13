//
//  MovieDetails.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let homepage: String?
    let status: String
    let runtime: Int?
    let budget: Double
    let revenue: Double
    let genres: [String]
    let spokenLanguages: [String]
}
