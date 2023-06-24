//
//  PornHub.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI

struct PornHub: View {
    @State var modelName : String
    var body: some View {
        if modelName != "" {
            let model = WebViewModel(urlString: "https://www.pornhub.com/view_video.php?viewkey=\(modelName)")
            WebView(webView: model.webView).preferredColorScheme(.dark)
        } else {
            let model = WebViewModel(urlString: "https://www.pornhub.com")
            WebView(webView: model.webView).preferredColorScheme(.dark)
        }
    }
}
