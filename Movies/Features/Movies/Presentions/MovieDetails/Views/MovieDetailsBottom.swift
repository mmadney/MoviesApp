//
//  MovieDetailsMiddleBar.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Kingfisher
import SwiftUI

struct MovieDetailsBottom: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            let movieDetails = viewModel.movieDetails
            HStack(alignment: .top, spacing: 12) {
                KFImage.url(movieDetails?.posterPath?.posterURL())
                    .placeholder {
                        Rectangle().fill(ThemeColor.darkGray)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 6) {
                    Text(movieDetails?.title ?? "")
                        .customFont(.title1, ThemeColor.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(viewModel.genresText)
                        .customFont(.label1, ThemeColor.white.opacity(0.85))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Text(movieDetails?.overview ?? "")
                .customFont(.label0, ThemeColor.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 10) {
                if let movieDetails = movieDetails, let homepage = movieDetails.homepage, let homepageURL = URL(string: homepage) {
                    HStack(alignment: .top, spacing: 8) {
                        Text("Homepage:")
                            .customFont(.label0, ThemeColor.white)

                        Link(homepage, destination: homepageURL)
                            .customFont(.label1, ThemeColor.yellow)
                            .lineLimit(2)
                    }
                }

                infoRow(title: "Languages", value: viewModel.spokenLanguagesText)
                infoRow(title: "Status", value: movieDetails?.status ?? "")
                infoRow(title: "Runtime", value: viewModel.runtimeText)
                infoRow(title: "Budget", value: viewModel.budgetText)
                infoRow(title: "Revenue", value: viewModel.revenueText)
            }
        }
    }

    func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("\(title):")
                .customFont(.label0, ThemeColor.white)
            Text(value)
                .customFont(.label1, ThemeColor.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    MovieDetailsBottom(viewModel: MovieDetailsViewModel(movieId: 1226863))
}
