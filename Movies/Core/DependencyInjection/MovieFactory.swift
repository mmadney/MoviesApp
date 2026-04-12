//
//  MovieFactory.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Factory
import Foundation

extension Container {
    // MARK: DataLayer --------------------------------------------------------------------------------------

    // Remote DataSource
    var movieRemoteDataSource: Factory<MoviesRemoteDataSource> {
        let remote = MoviesRemote()
        return self { remote }
    }

    // Local DataSource
    var localStorage: Factory<LocalStorages> {
        let storage = JsonLocalStorages()
        return self { storage }
    }

    var movieLocalDataSource: Factory<MoviesLocalDataSource> {
        let local = MoviesLocal(localStorage: localStorage())
        return self { local }
    }

    // MARK: DomainLayer --------------------------------------------------------------------------------------

    // Repository
    var movieRepository: Factory<MoviesRepo> {
        let repo = MoviesRepoImp(
            remote: movieRemoteDataSource(),
            local: movieLocalDataSource()
        )
        return self { repo }
    }
    

    // UseCases
    var getMoviesUseCase: Factory<GetMoviesUseCase> {
        let usecase = GetMoviesUseCase(repo: movieRepository())
        return self { usecase }
    }
    
    
    var getGeneresUseCase: Factory<GetGenresUseCase> {
        let usecase = GetGenresUseCase(repo: movieRepository())
        return self { usecase }
    }
}
