//
//  WebView.swift
//  GithubClient
//
//  Created by kim on 2025/4/30.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    WebView(URL(string: "https://github.com/Aaron0927/Snow/blob/main/README.md")!)
}
