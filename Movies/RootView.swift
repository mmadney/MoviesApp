//
//  RootView.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import SwiftUI

struct RootView: View {
    @State private var isSplashActive = true

    var body: some View {
        ZStack {
            if isSplashActive {
                SplashView()
                    .transition(.opacity)
            } else {
                NavigationStack {
                    MoviesListView()
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: isSplashActive)
        .task {
            try? await Task.sleep(for: .seconds(1.6))
            withAnimation {
                isSplashActive = false
            }
        }
    }
}

#Preview {
    RootView()
}
