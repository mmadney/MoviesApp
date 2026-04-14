//
//  MovieMocks.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

enum MovieMocks {
    static let starWars = Movie(
        id: 11,
        title: "Star Wars",
        releaseDate: "1977-05-25",
        poster: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        genreIds: [12, 28, 878]
    )

    static let encanto = Movie(
        id: 508947,
        title: "Encanto",
        releaseDate: "2021-11-24",
        poster: "/4j0PNHkMr5AX3YibJmwWa5Q3ImK.jpg",
        genreIds: [16, 35, 10751, 14]
    )

    static let empireStrikesBack = Movie(
        id: 1891,
        title: "The Empire Strikes Back",
        releaseDate: "1980-05-21",
        poster: "/dRZpjQ4XCmqb2dannqNcaEusVI0.jpg",
        genreIds: [12, 28, 878]
    )

    /// Default list for `GetMoviesUseCaseMock`.
    static let sample: [Movie] = [starWars, encanto, empireStrikesBack]
}
