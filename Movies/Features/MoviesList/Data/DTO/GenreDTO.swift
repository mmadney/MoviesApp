//
//  GenreDTO.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct GenresResponseDTO: Decodable {
    let genres: [GenreDTO]
}

struct GenreDTO: Decodable, Identifiable {
    let id: Int
    let name: String
}

extension GenreDTO {
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
