//
//  OnlyFans.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI

struct OnlyFans: View {
    @State var modelName : String
    var body: some View {
        let model = WebViewModel(urlString: "https://onlyfans.com/\(modelName)")
        WebView(webView: model.webView).preferredColorScheme(.light)
    }
}
