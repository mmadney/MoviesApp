//
//  SearchBar.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: MoviesListViewModel
    var body: some View {
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
}

#Preview {
    SearchBar(viewModel: MoviesListViewModel())
}
