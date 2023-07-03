//
//  WebView.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/3/23.
//

import SwiftUI

struct WebView: View {    
    @StateObject private var model: WebViewModel
    
    init(url: String) {
        _model = StateObject(wrappedValue: WebViewModel(urlString: url))
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color.black)
            VStack {
                WebViewWrapper(webView: model.webView)
                HStack {
                    Spacer()
                    Button(action: { model.webView.goBack() }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.vertical)
                    .disabled(!model.webView.canGoBack)
                    Spacer()
                    Button(action: { model.webView.goForward() }) {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.vertical)
                    .disabled(!model.webView.canGoForward)
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
