//
//  ContentView.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import SwiftUI

struct MoviesListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
                .customFont(.title1)
        }
        .background(ThemeColor.background)
        .padding()
    }
}

#Preview {
    MoviesListView()
}
