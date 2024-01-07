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
    
//    internal func parseResults(for recognizedText: [String]) -> CardModel {
//        //company
//        let company = recognizedText.first
//        
//        // Credit Card Number
//        let creditCardNumber = recognizedText.first(where: { $0.count >= 14 && ["4", "5", "3", "6"].contains($0.first) })
//        
//        // Expiry Date
//        let expiryDateString = recognizedText.first(where: { $0.count > 4 && $0.contains("/") })
//        let expiryDate = expiryDateString?.filter({ $0.isNumber || $0 == "/" })
//        
//        // Name
//        let ignoreList = ["GOOD THRU", "GOOD", "THRU", "Gold", "GOLD", "Standard", "STANDARD", "Platinum", "PLATINUM", "WORLD ELITE", "WORLD", "ELITE", "World Elite", "World", "Elite"]
//        let wordsToAvoid = [creditCardNumber, expiryDateString] + ignoreList +
//        CardType.allCases.map { $0.rawValue } +
//        CardType.allCases.map { $0.rawValue.lowercased() } +
//        CardType.allCases.map { $0.rawValue.uppercased() }
//        let name = recognizedText.filter({ !wordsToAvoid.contains($0) }).last
//        
//        return CardModel(numberWithDelimiters: creditCardNumber, name: name, expiryDate: expiryDate)
//        return CardModel(company: company, name: <#T##String?#>, jobTitle: <#T##String?#>, email: <#T##String?#>, mobile: <#T##String?#>, address: <#T##String?#>, imageName: <#T##String?#>, group: <#T##Group?#>, website: <#T##String?#>)
//    }
}
