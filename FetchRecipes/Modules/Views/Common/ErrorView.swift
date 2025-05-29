//
//  ErrorView.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/29/25.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    var body: some View {
        Text(error)
            .foregroundColor(.red)
            .padding()
    }
}

#Preview {
    ErrorView(error: "oops")
}
