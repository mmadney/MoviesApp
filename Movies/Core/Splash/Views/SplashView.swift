//
//  SplashView.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            ThemeColor.background.ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "film.stack")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(ThemeColor.yellow)

                Text("Movies")
                    .customFont(.title2, ThemeColor.yellow)
            }
        }
    }
}

#Preview {
    SplashView()
}
