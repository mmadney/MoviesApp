//
//  ContentView.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel = MoviesListViewModel()

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    private let posterBaseURL = "https://image.tmdb.org/t/p/w500"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                searchBar

                Text("Watch New Movies")
                    .customFont(.title2, ThemeColor.yellow)

                genresSection

                if let errorMessage = viewModel.errorMessage, viewModel.visibleMovies.isEmpty {
                    Text(errorMessage)
                        .customFont(.label1, ThemeColor.white)
                }

                moviesGrid

                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .tint(ThemeColor.yellow)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background(ThemeColor.background.ignoresSafeArea())
        .task {
            await viewModel.onAppear()
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(ThemeColor.white.opacity(0.7))

            TextField("Search TMDB", text: $viewModel.searchText)
                .customFont(.label1, ThemeColor.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(ThemeColor.white)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(ThemeColor.darkGray.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var genresSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                genreChip(title: "All", isSelected: viewModel.selectedGenreId == nil) {
                    Task { await viewModel.selectGenre(nil) }
                }

                ForEach(viewModel.genres, id: \.id) { genre in
                    genreChip(title: genre.name, isSelected: viewModel.selectedGenreId == genre.id) {
                        Task { await viewModel.selectGenre(genre.id) }
                    }
                }
            }
        }
    }

    private var moviesGrid: some View {
        LazyVGrid(columns: gridColumns, spacing: 12) {
            ForEach(viewModel.visibleMovies, id: \.id) { movie in
                VStack(alignment: .leading, spacing: 0) {
                    AsyncImage(url: posterURL(from: movie.poster)) { phase in
                        switch phase {
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()
                        default:
                            Rectangle()
                                .fill(ThemeColor.darkGray)
                                .overlay {
                                    Image(systemName: "film")
                                        .foregroundColor(ThemeColor.white.opacity(0.65))
                                }
                        }
                    }
                    .frame(height: 230)
                    .frame(maxWidth: .infinity)
                    .clipped()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .customFont(.subTitle, ThemeColor.white)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(releaseYear(from: movie.releaseDate))
                            .customFont(.label0, ThemeColor.white)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ThemeColor.darkGray.opacity(0.35))
                }
                .background(ThemeColor.darkGray.opacity(0.22))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .task {
                    await viewModel.loadNextPageIfNeeded(currentMovie: movie)
                }
            }
        }
    }

    private func genreChip(title: String, isSelected: Bool, onTap: @escaping () -> Void) -> some View {
        Button(action: onTap) {
            Text(title)
                .customFont(.label0, isSelected ? ThemeColor.background : ThemeColor.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? ThemeColor.yellow : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ThemeColor.yellow, lineWidth: 1)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private func posterURL(from path: String?) -> URL? {
        guard let path, !path.isEmpty else { return nil }
        return URL(string: "\(posterBaseURL)\(path)")
    }

    private func releaseYear(from releaseDate: String) -> String {
        return String(releaseDate.prefix(4))
    }
}

#Preview {
    MoviesListView()
        .preferredColorScheme(.dark)
}
