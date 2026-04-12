//
//  ContentView.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel = MoviesListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SearchBar(viewModel: viewModel)

            Text("Watch New Movies")
                .customFont(.title2, ThemeColor.yellow)

            GenreSection(viewModel: viewModel)

            if let errorMessage = viewModel.errorMessage, viewModel.visibleMovies.isEmpty {
                Text(errorMessage)
                    .customFont(.label1, ThemeColor.white)
            }

            MoviesGrid(viewModel: viewModel)

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
        .frame(maxHeight: .infinity, alignment: .top)
        .background(ThemeColor.background.ignoresSafeArea())
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    MoviesListView()
        .preferredColorScheme(.dark)
}
