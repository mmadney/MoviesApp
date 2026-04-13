//
//  MovieDetailsDTO.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

struct MovieDetailsDTO: Decodable {
    let adult: Bool
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let imdbId: String?
    let overview: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let homepage: String?
    let tagline: String?
    let status: String
    let runtime: Int?
    let budget: Double
    let revenue: Double
    let originCountry: [String]
    let genres: [GenreNameDTO]
    let spokenLanguages: [SpokenLanguageDTO]

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case imdbId = "imdb_id"
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case homepage
        case tagline
        case status
        case runtime
        case budget
        case revenue
        case originCountry = "origin_country"
        case genres
        case spokenLanguages = "spoken_languages"
    }
}

struct GenreNameDTO: Decodable {
    let id: Int
    let name: String
}

struct SpokenLanguageDTO: Decodable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

extension MovieDetailsDTO {
    func toDomain() -> MovieDetails {
        MovieDetails(
            id: id,
            title: title,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            backdropPath: backdropPath,
            homepage: homepage,
            status: status,
            runtime: runtime,
            budget: budget,
            revenue: revenue,
            genres: genres.map { $0.name },
            spokenLanguages: spokenLanguages.map { $0.name }
        )
    }
}
