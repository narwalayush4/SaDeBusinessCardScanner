//
//  ImageTextRecognizable.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 10/10/23.
//

import Foundation
import Vision
import VisionKit

public protocol ImageTextRecognizable: VNDocumentCameraViewControllerDelegate { }

public extension ImageTextRecognizable {
    
    internal func validateImage(image: UIImage?, completion: @escaping (Card?) -> Void){
        
        guard let cgImage = image?.cgImage else { return completion(nil) }
        
        var recognizedText = [String]()
        
        var textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.customWords = ["Phone", "Mobile", "Email"]
        
        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
           guard let results = request.results,
                 !results.isEmpty,
                 let requestResults = request.results as? [VNRecognizedTextObservation]
           else { return completion(nil) }
           recognizedText = requestResults.compactMap { observation in
              return observation.topCandidates(1).first?.string
           }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            let card = Card()
            try handler.perform([textRecognitionRequest])
//            completion(parseResults(for: recognizedText))
            completion(card)
            print(recognizedText)
        } catch {
            print(error)
        }
    }
}
