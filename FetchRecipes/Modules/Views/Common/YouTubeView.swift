//
//  YouTubeView.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/29/25.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let urlString: String
    @Binding var failedToLoad: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url:url)
            uiView.load(request)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubeView
        
        init(_ parent: YouTubeView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Youtube video failed to load")
            DispatchQueue.main.async {
                self.parent.failedToLoad = true
            }
        }
    }
}

#Preview {
    let url = "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    YouTubeView(urlString: url, failedToLoad: .constant(false))
}
