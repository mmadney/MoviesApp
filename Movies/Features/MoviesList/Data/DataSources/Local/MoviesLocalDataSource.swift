//
//  MovieListLocalStore.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol MoviesLocalDataSource {
    func saveGenres(_ response: GenresResponseDTO)
    func getGenres() -> [Genre]

    func saveMovies(_ response: MoviesResponseDTO, page: Int, genreId: Int?)
    func getMovies(page: Int, genreId: Int?) -> [Movie]
    func searchMoviesByGenre(genreId: Int?) -> [Movie]
}
