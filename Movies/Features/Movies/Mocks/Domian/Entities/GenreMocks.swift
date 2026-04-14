//
//  GenreMocks.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

enum GenreMocks {
    static let action = Genre(id: 28, name: "Action")
    static let adventure = Genre(id: 12, name: "Adventure")
    static let animation = Genre(id: 16, name: "Animation")
    static let comedy = Genre(id: 35, name: "Comedy")
    static let drama = Genre(id: 18, name: "Drama")
    static let scienceFiction = Genre(id: 878, name: "Science Fiction")

    static let sample: [Genre] = [
        action,
        adventure,
        animation,
        comedy,
        drama,
        scienceFiction,
    ]
}
