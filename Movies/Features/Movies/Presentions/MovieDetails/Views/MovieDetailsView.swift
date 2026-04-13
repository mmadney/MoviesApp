//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Kingfisher
import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.movieDetails == nil {
                ProgressView()
                    .tint(ThemeColor.yellow)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.movieDetails != nil {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        MovieDetailsTopBar(viewModel: viewModel)
                        
                        MovieDetailsBottom(viewModel: viewModel)
                            .padding(.horizontal , 10)
                            .padding(.bottom , 10)
                    }
                }
            } else {
                failureView
            }
        }
        .background(ThemeColor.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.onAppear()
        }
    }


    private var failureView: some View {
        VStack(spacing: 12) {
            Text(viewModel.errorMessage ?? "Something went wrong.")
                .customFont(.label1, ThemeColor.white)
                .multilineTextAlignment(.center)

            Button("Retry") {
                Task {
                    await viewModel.retry()
                }
            }
            .customFont(.label0, ThemeColor.yellow)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: 1226863))
}
