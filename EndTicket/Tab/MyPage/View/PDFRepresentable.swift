import SwiftUI
import PDFKit

struct PDFRepresentable: UIViewRepresentable {
    let url: URL
    init(url:URL){
        self.url = url
    }
    func makeUIView(context: UIViewRepresentableContext<PDFRepresentable>) -> PDFRepresentable.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFRepresentable>) {
        // Update the view.
    }
}
