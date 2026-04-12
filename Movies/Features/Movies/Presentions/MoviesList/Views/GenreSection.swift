//
//  GenreSection.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import SwiftUI

struct GenreSection: View {
    @ObservedObject var viewModel: MoviesListViewModel

    var body: some View {
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
            .padding(.horizontal , 2)
        }
    }

    private func genreChip(title: String, isSelected: Bool, onTap: @escaping () -> Void) -> some View {
        Button(action: onTap) {
            Text(title)
                .customFont(.label0, isSelected ? ThemeColor.background : ThemeColor.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? ThemeColor.yellow : Color.clear)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ThemeColor.yellow, lineWidth: 1)
                )
                .padding(.vertical , 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    GenreSection(viewModel: MoviesListViewModel())
}
