//
//  MockGetGenresUseCase.swift
//  Movies
//
//  Created by Madney on 14/04/2026.
//

import Foundation

struct MockGetGenresUseCase: GetGenresUseCase {
    let result: Result<[Genre], Error>

    init(result: Result<[Genre], Error> = .success(GenreMocks.sample)) {
        self.result = result
    }

    func execute() async throws -> [Genre] {
        try result.get()
    }
}
