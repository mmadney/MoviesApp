//
//  JsonMock.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

enum JsonMock {
    static let genres =
        """
        {
          "genres": [
            {
              "id": 28,
              "name": "Action"
            },
            {
              "id": 12,
              "name": "Adventure"
            }
          ]
        }
        """

    static let Movies = """
    {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/1x9e0qWonw634NhIsRdvnneeqvN.jpg",
          "genre_ids": [
            10749,
            18
          ],
          "id": 1523145,
          "original_language": "ru",
          "original_title": "Твоё сердце будет разбито",
          "overview": "High school student Polina is saved from bullying at her new school and makes a deal with the main bully Bars: he must pretend to be her boyfriend and protect her, and she must do everything he says. During this game, the couple develops real feelings, but her family and classmates have reasons to separate the lovers.",
          "popularity": 821.6874,
          "poster_path": "/7wIBfBl2gejt6xHxNSK0reVIm7E.jpg",
          "release_date": "2026-03-26",
          "title": "Your Heart Will Be Broken",
          "video": false,
          "vote_average": 7.0,
          "vote_count": 56
        },
        {
          "adult": false,
          "backdrop_path": "/kxQiIJ4gVcD3K6o14MJ72p5yRcE.jpg",
          "genre_ids": [
            10751,
            35,
            12,
            14,
            16,
            18
          ],
          "id": 1226863,
          "original_language": "en",
          "original_title": "The Super Mario Galaxy Movie",
          "overview": "Having thwarted Bowser's previous plot to marry Princess Peach, Mario and Luigi now face a fresh threat in Bowser Jr., who is determined to liberate his father from captivity and restore the family legacy. Alongside companions new and old, the brothers travel across the stars to stop the young heir's crusade.",
          "popularity": 495.4169,
          "poster_path": "/eJGWx219ZcEMVQJhAgMiqo8tYY.jpg",
          "release_date": "2026-04-01",
          "title": "The Super Mario Galaxy Movie",
          "video": false,
          "vote_average": 6.836,
          "vote_count": 418
        }
      ],
      "total_pages": 56148,
      "total_results": 1122941
    }
    """

    static let singleMovieJSON = """
    {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": null,
          "genre_ids": [28],
          "id": 5,
          "original_language": "en",
          "original_title": "X",
          "overview": "O",
          "popularity": 1.0,
          "poster_path": null,
          "release_date": "2020-01-01",
          "title": "X",
          "video": false,
          "vote_average": 5.0,
          "vote_count": 1
        }
      ],
      "total_pages": 1,
      "total_results": 1
    }
    """
}
