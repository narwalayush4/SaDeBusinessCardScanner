////
////  CardReaderView.swift
////  SaDeBusinessCardScanner
////
////  Created by Ayush Narwal on 05/10/23.
////
//
//import SwiftUI
//import Vision
//import VisionKit
//
//
//struct CardScannerView: UIViewControllerRepresentable{
//
//    private let completionHandler: (CardModel?) -> Void
//    private let onCancel: () -> Void
//    
//    init(completionHandler: @escaping (CardModel?) -> Void, onCancel: @escaping () -> Void) {
//        self.completionHandler = completionHandler
//        self.onCancel = onCancel
//    }
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<CardScannerView>) -> VNDocumentCameraViewController {
//        print("card scanner view loaded")
//        let viewController = VNDocumentCameraViewController()
//        viewController.delegate = context.coordinator
//        return viewController
//    }
//    
//    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CardScannerView>) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(completionHandler: completionHandler, onCancel: onCancel)
//    }
//    
//    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, ImageTextRecognizable {
//        private let completionHandler: (CardModel?) -> Void
//        private let onCancel: () -> Void
//        
//        init(completionHandler: @escaping (CardModel?) -> Void, onCancel: @escaping () -> Void){
//            self.completionHandler = completionHandler
//            self.onCancel = onCancel
//        }
//        
//        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
//            
//            if scan.pageCount != 1 {
//                // Notify the user
//                let alert = UIAlertController(title: "Capture Error", message: "Please capture only one card at a time.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK",
//                                              style: .default,
//                                              handler: { _ in
//                    // Dismiss the document scanner or take appropriate action
////                    controller.dismiss(animated: true, completion: nil)
//                }))
////                controller.present(alert, animated: true, completion: nil)
//            }
//            print("Document camera view controller did finish with ", scan)
//            let image = scan.imageOfPage(at: 0)
//            let recognizer = TextRecognizer()
//            recognizer.validateImage(image: image, withCompletionHandler: completionHandler)
////            print(controller.delegate ?? "lol")
//            controller.delegate = nil
////            print("delegate is \(String(describing: controller.delegate))")
//        }
//        
//        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController){
//            onCancel()
//            completionHandler(nil)
//        }
//        
//        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error){
//            print("Document camera view controller did finish with error ", error)
//            completionHandler(nil)
//        }
//        
//    }
//}
//
