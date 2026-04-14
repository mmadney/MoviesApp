# Movies iOS App

A SwiftUI movie browsing app built with a feature-first Clean Architecture style.

## Demo

![Movies app demo](docs/demo.gif)


## Features

- Browse movies with pagination.
- Filter movies by genre.
- Search movies by title.
- Open detailed movie information screen.
- Offline/local caching support through local data source abstractions.
- Unit tests for domain, data, and presentation layers.

## Tech Stack

- Swift
- SwiftUI
- URLSession networking
- Factory (dependency injection)
- XCTest / XCUITest
- TMDB API

## Project Structure

```text
Movies/
├── docs/
│   └── demo.gif          
├── Movies/
│   ├── Core/
│   │   ├── DependencyInjection/
│   │   ├── Extensions/
│   │   ├── Network/
│   │   ├── Resources/
│   │   ├── Splash/
│   │   └── Utils/
│   ├── Features/
│   │   └── Movies/
│   │       ├── Data/
│   │       │   ├── DataSources/
│   │       │   │   ├── Local/
│   │       │   │   └── Remote/
│   │       │   ├── DTO/
│   │       │   └── RepoImp/
│   │       ├── Domain/
│   │       │   ├── Entities/
│   │       │   ├── Repo/
│   │       │   └── UseCases/
│   │       ├── Mocks/
│   │       └── Presentions/
│   │           ├── MovieDetails/
│   │           └── MoviesList/
│   ├── MoviesApp.swift
│   └── RootView.swift
├── MoviesTests/
├── MoviesUITests/
└── Movies.xcodeproj
```

## Architecture

The app is split into clear layers:

- **Presentation**: SwiftUI views + view models.
- **Domain**: business entities and use cases.
- **Data**: repository implementations, remote/local data sources, DTO mapping.
- **Core**: shared network, configuration, theming, and DI setup.

## Getting Started

1. Open `Movies.xcodeproj` in Xcode.
2. Select an iOS simulator.
3. Run the `Movies` scheme.

## API Configuration

This project uses TMDB endpoints. Make sure your API authorization setup is valid for public sharing:

- Review the Authorization header in `Movies/Core/Network/EndPoint.swift`.
- Replace hardcoded credentials with secure configuration (recommended for public repos).

## Run Tests

- Unit tests: run `MoviesTests`.
- UI tests: run `MoviesUITests`.

## Future Improvements

- Move API keys/tokens to secure runtime configuration.
- Add CI workflow for build and test automation.
