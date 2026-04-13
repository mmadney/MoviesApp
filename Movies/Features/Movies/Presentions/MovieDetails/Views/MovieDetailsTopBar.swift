//
//  MovieDetailsTopBar.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Kingfisher
import SwiftUI

struct MovieDetailsTopBar: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let movieDetails = viewModel.movieDetails
            ZStack(alignment: .topLeading) {
                KFImage
                    .url(
                        (movieDetails?.posterPath)?.posterURL()
                    )
                    .placeholder {
                        Rectangle().fill(ThemeColor.darkGray)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .clipped()

                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(ThemeColor.white)
                        .padding(10)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                }
                .padding([.leading, .top], 10)
            }
        }
    }
}

#Preview {
    MovieDetailsTopBar(viewModel: MovieDetailsViewModel(movieId: 1226863))
}
