//
//  WebViewModel.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI
import WebKit

class WebViewModel:NSObject, ObservableObject {
    let webView: WKWebView
    let url: URL
    @Published var loading = false
    
    init(urlString: String) {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        url = URL(string: urlString)!
        super.init()
        webView.navigationDelegate = self
        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
    
    func updateLoadingState(_ loading: Bool) {
        self.loading = loading
    }
    
}

extension WebViewModel: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateLoadingState(false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        updateLoadingState(false)
    }
}

struct WebViewWrapper: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
