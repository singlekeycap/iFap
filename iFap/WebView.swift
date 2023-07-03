//
//  WebView.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/3/23.
//

import SwiftUI

struct WebView: View {
    @State var url : String
    var body: some View {
        let model = WebViewModel(urlString: url)
        WebViewWrapper(webView: model.webView)
    }
}
