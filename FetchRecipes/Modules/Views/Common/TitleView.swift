//
//  TitleView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/29/25.
//

/// Reusable title bar with a back button, title, and optional refresh button
///
/// - Parameters:
///     - title: The text to display as the title
///     - onBack: Closure executed once back is tapped
///     - onRefresh: Optional, reloads current list to display updates

import SwiftUI

struct TitleView: View {
    let title: String
    let onBack: () -> Void
    let onRefresh: (() -> Void)?
    
    var body: some View {
        HStack{
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            Spacer()
            Text(title)
                .font(.headline)
            Spacer()
            refreshButton(icon: "arrow.clockwise", action: onRefresh)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // Only show button in recipe list view
    func refreshButton(icon: String, action: (() -> Void)?) -> some View {
        Group {
            if let action = action {
                Button(action: action) {
                    Image(systemName: icon)
                        .font(.title2)
                }
            } else {
                Button(action: {}) {
                    Image(systemName: icon)
                        .font(.title2)
                        .opacity(0)
                }
                .disabled(true)
            }
        }
    }
}

#Preview {
    TitleView(title: "Test", onBack: {print("Back Button Pressed")}, onRefresh: nil)
}
