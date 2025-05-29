//
//  LoadingView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/29/25.
//

/// SwiftUI view that displays a loading spinner with a message.
///
/// `LoadingView` will present a `ProgressView` alongside a "Loading recipes..." message

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading recipes...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoadingView()
}
