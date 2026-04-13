//
//  MoviesGrid.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Kingfisher
import SwiftUI

struct MoviesGrid: View {
    @ObservedObject var viewModel: MoviesListViewModel

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                LazyVGrid(columns: gridColumns, spacing: 12) {
                    ForEach(viewModel.visibleMovies, id: \.id) { movie in
                        VStack(alignment: .leading, spacing: 0) {
                            KFImage.url(movie.poster?.posterURL())
                                .placeholder({
                                    placeholderImage
                                })
                                .resizable()
                                .frame(height: 230)
                                .frame(maxWidth: .infinity)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(movie.title)
                                    .customFont(.subTitle, ThemeColor.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(String(movie.releaseDate.prefix(4)))
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
        }
    }

    var placeholderImage: some View {
        Rectangle()
            .fill(ThemeColor.darkGray)
            .overlay {
                Image(systemName: "film")
                    .foregroundColor(ThemeColor.white.opacity(0.65))
            }
    }
}

#Preview {
    MoviesGrid(viewModel: MoviesListViewModel())
}
