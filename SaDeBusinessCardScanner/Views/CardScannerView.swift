//
//  CardReaderView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 05/10/23.
//

import SwiftUI
import Vision
import VisionKit


struct CardScannerView: UIViewControllerRepresentable {
    
    private let completionHandler: () -> Void
    @Binding var scannedCard: CardModel
    private let onCancel: () -> Void
    
    init(completionHandler: @escaping () -> Void, scannedCard: Binding<CardModel>, onCancel: @escaping () -> Void) {
        self.completionHandler = completionHandler
        _scannedCard = scannedCard
        self.onCancel = onCancel
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CardScannerView>) -> VNDocumentCameraViewController {
        debugPrint("card scanner view loaded")
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CardScannerView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler, scannedCard: $scannedCard, onCancel: onCancel)
    }
    
    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, ImageTextRecognizable {
        private let completionHandler: () -> Void
        @Binding var scannedCard: CardModel
        private let onCancel: () -> Void
        
        init(completionHandler: @escaping () -> Void, scannedCard: Binding<CardModel>, onCancel: @escaping () -> Void){
            self.completionHandler = completionHandler
            _scannedCard = scannedCard
            self.onCancel = onCancel
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
            
            if scan.pageCount != 1 {
                // Notify the user
                let alert = UIAlertController(title: "Capture Error", message: "Please capture only one card at a time.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                }))
            }
            print("Document camera view controller did finish with ", scan)
            let image = scan.imageOfPage(at: 0)
            let recognizer = TextRecognizer()
            scannedCard = recognizer.validateImage(image: image) ?? CardModel()
//            recognizer.validateImage(image: image, withCompletionHandler: completionHandler)
            controller.delegate = nil
            completionHandler()
        }
        
        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController){
            onCancel()
//            completionHandler(nil)
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error){
            print("Document camera view controller did finish with error ", error)
//            completionHandler(nil)
        }
        
    }
}

#Preview{
    func completionHandler(){}
    func onCancel(){}
    return CardScannerView(completionHandler: completionHandler, scannedCard: .constant(CardModel()), onCancel: onCancel)
}

