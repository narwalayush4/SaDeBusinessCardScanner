//
//  ScannerViewVM.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import Foundation
import Vision
import VisionKit
import UIKit

class TextRecognizer {
    
    internal func validateImage(image: UIImage?) -> CardModel? {
        
        guard let cgImage = image?.cgImage else { return nil }
        
        var recognizedText = [String]()
        
        var textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.recognitionLanguages = ["en-US"]
        
        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
           guard let results = request.results,
                 !results.isEmpty,
                 let requestResults = request.results as? [VNRecognizedTextObservation]
           else { return }
           recognizedText = requestResults.compactMap { observation in
              return observation.topCandidates(1).first?.string
           }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
            print(recognizedText)
            let card = parseResults(for: recognizedText, from: cgImage)
            FileSystem().saveImage(image: cgImage, date: card!.timeStamp_)
            return card
        } catch {
            print(error)
            return nil
        }
    }
    
    internal func parseResults(for recognizedText: [String], from image: CGImage) -> CardModel? {
        var linesToKeep = [String]()
        var card = CardModel()
        for line in recognizedText {
            if let email = extractEmail(from: line) {
                card.email_ = email
            } else if let website = extractWebsite(from: line) {
                card.website_ = website
            } else if let phoneNumber = extractPhoneNumber(from: line) {
                card.phone_ = phoneNumber
            } else {
                linesToKeep.append(line)
            }
        }
        card.company_ = linesToKeep.first ?? ""
        if linesToKeep.count > 2 {
            card.name_ = linesToKeep[1]
        }
        if linesToKeep.count > 3 {
            card.jobTitle_ = linesToKeep[2]
        }
        if linesToKeep.count > 4 {
            card.address2_ = linesToKeep[3]
        }
        if linesToKeep.count >  5 {
            card.address2_ = linesToKeep[5]
        }
        if linesToKeep.count > 6 {
            card.address3_ = linesToKeep[6]
        }
        card.timeStamp_ = Date()
        card.options = recognizedText
        return card
    }
    
//    internal func validateImage(image: UIImage?, withCompletionHandler completion: @escaping (CardModel?) -> Void){
//        
//        guard let cgImage = image?.cgImage else { return completion(nil) }
//        
//        var recognizedText = [String]()
//        
//        var textRecognitionRequest = VNRecognizeTextRequest()
//        textRecognitionRequest.recognitionLevel = .accurate
//        textRecognitionRequest.usesLanguageCorrection = false
//        textRecognitionRequest.recognitionLanguages = ["en-US"]
//        
//        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
//           guard let results = request.results,
//                 !results.isEmpty,
//                 let requestResults = request.results as? [VNRecognizedTextObservation]
//           else { return completion(nil) }
//           recognizedText = requestResults.compactMap { observation in
//              return observation.topCandidates(1).first?.string
//           }
//        }
//        
//        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        do {
//            try handler.perform([textRecognitionRequest])
//            print(recognizedText)
//            let card = parseResults(for: recognizedText, from: cgImage)
//            completion(card)
//        } catch {
//            print(error)
//        }
//    }
    
//    internal func parseResults(for recognizedText: [String], from image: CGImage) -> CardModel? {
//        var linesToKeep = [String]()
//        var card = CardModel()
//        for line in recognizedText {
//            if let email = extractEmail(from: line) {
//                card.email_ = email
//            } else if let website = extractWebsite(from: line) {
//                card.website_ = website
//            } else if let phoneNumber = extractPhoneNumber(from: line) {
//                card.phone_ = phoneNumber
//            } else {
//                linesToKeep.append(line)
//            }
//        }
//        card.company_ = linesToKeep.first ?? ""
//        card.name_ = linesToKeep[1]
//        card.jobTitle_ = linesToKeep[2]
//        card.address1_ = linesToKeep[3]
//        card.address2_ = ""
//        card.address3_ = ""
//        card.timeStamp_ = Date()
//        fileManager.saveImage(image: image, date: card.timeStamp_)
////        card.filePath_ = card.timeStamp_.description
//        return card
//    }
    
    func extractEmail(from line: String) -> String? {
        // Example: "Email: john.doe@email.com" or "john.doe@email.com"
        let pattern = #"\b(?:E-?mail: )?([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})\b"#
        if (NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: line)){
            
            let regexPattern = #"(?i)\b(?:e-?mail:?\s*)"# // Case-insensitive regex to match "E-mail", "e-mail", "Email", "email", etc.
            do {
                let regex = try NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
                let range = NSRange(line.startIndex..., in: line)
                
                let modifiedString = regex.stringByReplacingMatches(in: line, options: [], range: range, withTemplate: "")
                return modifiedString.trimmingCharacters(in: .whitespacesAndNewlines)
            } catch {
                print("Error creating regular expression: \(error)")
                return line // Return the original string in case of an error.
            }
        }
        return nil
    }
    func extractWebsite(from line: String) -> String? {
        // Example: "Website: www.example.com" or "www.example.com"
        let pattern = #"\b(?:Website: )?((?:https?://)?(www\.)?[\w.-]+\.[A-Za-z]{2,})\b"#
        if (NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: line)){
            return line
        }
        return nil
    }
    func extractPhoneNumber(from line: String) -> String? {

        let digitsOnly = line.filter({$0.isNumber})
        if (digitsOnly.count >= 8){
            
            let regexPattern = #"(?i)\b(?:tel\.|mob\.|mobile|phone):\s*\+?[\d\s]+"# // Case-insensitive regex to match prefixes
            
            do {
                let regex = try NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
                let range = NSRange(line.startIndex..., in: line)
                
                let modifiedString = regex.stringByReplacingMatches(in: line, options: [], range: range, withTemplate: "")
                return modifiedString.trimmingCharacters(in: .whitespacesAndNewlines)
            } catch {
                print("Error creating regular expression: \(error)")
                return line // Return the original string in case of an error.
            }
            
        }
        return nil
        
        //        let pattern = "\\d{8,}" // This regex matches 8 or more digits.
        //
        //        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        //
        //        if let match = regex?.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.utf16.count)) {
        //            if let range = Range(match.range, in: line) {
        //                let matchedText = String(line[range])
        //                print("Phone number found: \(matchedText)")
        //                return matchedText
        //            }
        //        }
    }
    
    func cgImagetoData(cgImage: CGImage) -> Data{
        let uiImage = UIImage(cgImage: cgImage)
        if let data = uiImage.pngData() {
            return data
        }
        // If pngData() fails, you can try using jpegData() as a fallback:
        if let data = uiImage.jpegData(compressionQuality: 1.0) {
            return data
        }
        return Data()
    }
    
}

//    func extractPhoneNumber(from line: String) -> String? {
////        print("extract phone ran \(line)")
////        let pattern = "\\d{8,}"
////        if (NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: line)){
////            print("phone number found \(line)")
////            if let digitsOnly = line.components(separatedBy: CharacterSet.decimalDigits.inverted).first, digitsOnly.count >= 8 {
////                print("phone number long \(digitsOnly)")
////                return digitsOnly
////            }
////        }
////        return nil
//
//        do {
//            let regex = try NSRegularExpression(pattern: "\\d", options: [])
//            let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.utf16.count))
//            if (matches.count >= 8){
//                return line
//            }
//        } catch {
////            print("Error creating regular expression: \(error)")
//            return nil
//        }
//        return nil
//    }
