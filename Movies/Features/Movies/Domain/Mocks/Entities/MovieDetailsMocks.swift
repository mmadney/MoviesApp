//
//  MovieDetailsMocks.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

enum MovieDetailsMocks {
    /// Sample details aligned with TMDB `movie/11` (Star Wars).
    static let sample = MovieDetails(
        id: 11,
        title: "Star Wars",
        originalTitle: "Star Wars",
        originalLanguage: "en",
        overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire.",
        releaseDate: "1977-05-25",
        posterPath: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        backdropPath: "/2w4xG178RpB4MDAIfTkqAuSJzec.jpg",
        homepage: "http://www.starwars.com/films/star-wars-episode-iv-a-new-hope",
        status: "Released",
        runtime: 121,
        budget: 11_000_000,
        revenue: 775_398_007,
        genres: ["Adventure", "Action", "Science Fiction"],
        spokenLanguages: ["English"]
    )
}
