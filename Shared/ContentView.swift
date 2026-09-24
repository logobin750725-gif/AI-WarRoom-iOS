import SwiftUI
import WebKit

struct ContentView: View {
    let title: String
    let subtitle: String
    let resource: String

    var body: some View {
        WebView(resource: resource)
            .ignoresSafeArea()
    }
}

struct WebView: UIViewRepresentable {
    let resource: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        let view = WKWebView(frame: .zero, configuration: config)
        view.allowsBackForwardNavigationGestures = true
        return view
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard webView.url == nil,
              let url = Bundle.main.url(forResource: resource, withExtension: "html") else { return }
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
