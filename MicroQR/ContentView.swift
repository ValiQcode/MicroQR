import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        VStack {
            Text("QR Code Example")
                .font(.title)
                .padding()
            
            if let qrCode = try? createQRCode() {
                QRCodeView(qrCode: qrCode)
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("Failed to generate QR code")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func createQRCode() throws -> QRCode {
        // Create a simple QR code with hardcoded data
        return try QRCode.create(
            "Hello, World!",
            errorLevel: .medium
        )
        .moduleSize(4)  // Make modules smaller for SwiftUI view
        .colors(front: .init(red: 0, green: 0, blue: 0))
    }
}

struct QRCodeView: View {
    let qrCode: QRCode
    
    var body: some View {
        if let svgString = try? qrCode.svg(),
           let data = svgString.data(using: .utf8) {
            WebView(data: data)
        } else {
            Text("Failed to render QR code")
                .foregroundColor(.red)
        }
    }
}

#if os(iOS)
struct WebView: UIViewRepresentable {
    let data: Data
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(data,
                    mimeType: "image/svg+xml",
                    characterEncodingName: "UTF-8",
                    baseURL: Bundle.main.bundleURL)
    }
}
#elseif os(macOS)
struct WebView: NSViewRepresentable {
    let data: Data
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        webView.load(data,
                    mimeType: "image/svg+xml",
                    characterEncodingName: "UTF-8",
                    baseURL: Bundle.main.bundleURL)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
