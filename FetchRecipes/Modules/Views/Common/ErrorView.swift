//
//  ErrorView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/29/25.
//

/// SwiftUI view that displays error messagse
///
/// Use `ErrorView` to present error messages on screen
/// - Parameter error: The error message to display on screen

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
