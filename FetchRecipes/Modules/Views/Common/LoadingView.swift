//
//  LoadingView.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/29/25.
//

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
