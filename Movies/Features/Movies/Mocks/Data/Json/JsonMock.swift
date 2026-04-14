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

    static let movieDetails = """
    {
      "adult": false,
      "backdrop_path": "/yUiXA68FfQeA8cRBhd0Ao0jIRZt.jpg",
      "belongs_to_collection": {
        "id": 10,
        "name": "Star Wars Collection",
        "poster_path": "/pWVLFh4OuejTpUaDQbB1C4zoS2p.jpg",
        "backdrop_path": "/iY2ujEY2m68OTTlPFTiHub9joHS.jpg"
      },
      "budget": 11000000,
      "genres": [
        {
          "id": 12,
          "name": "Adventure"
        },
        {
          "id": 28,
          "name": "Action"
        },
        {
          "id": 878,
          "name": "Science Fiction"
        }
      ],
      "homepage": "http://www.starwars.com/films/star-wars-episode-iv-a-new-hope",
      "id": 11,
      "imdb_id": "tt0076759",
      "origin_country": [
        "US"
      ],
      "original_language": "en",
      "original_title": "Star Wars",
      "overview": "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
      "popularity": 22.2755,
      "poster_path": "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
      "production_companies": [
        {
          "id": 1,
          "logo_path": "/tlVSws0RvvtPBwViUyOFAO0vcQS.png",
          "name": "Lucasfilm Ltd.",
          "origin_country": "US"
        },
        {
          "id": 25,
          "logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
          "name": "20th Century Fox",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "US",
          "name": "United States of America"
        }
      ],
      "release_date": "1977-05-25",
      "revenue": 775398007,
      "runtime": 121,
      "spoken_languages": [
        {
          "english_name": "English",
          "iso_639_1": "en",
          "name": "English"
        }
      ],
      "status": "Released",
      "tagline": "A long time ago in a galaxy far, far away...",
      "title": "Star Wars",
      "video": false,
      "vote_average": 8.202,
      "vote_count": 22153
    }
    """
}
