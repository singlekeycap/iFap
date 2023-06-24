//
//  WebViewModel.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    let webView: WKWebView
    let url: URL
    
    init(urlString: String) {
        webView = WKWebView(frame: .zero)
        url = URL(string: urlString)!
        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
