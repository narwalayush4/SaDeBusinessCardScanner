//
//  FileManager.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 07/11/23.
//

import Foundation
import UIKit
import Dispatch

struct FileSystem {
    
    let imagesDirectory: URL
    init(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        imagesDirectory = documentsDirectory.appendingPathComponent("SaDe Business Card Scanner")
        do {
            if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
                try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            print("Error creating directory: \(error)")
        }
    }
    
    func saveImage(image cgImage: CGImage, date: Date){
        // Append a unique filename to the document directory URL
        let fileURL = imagesDirectory.appendingPathComponent(formatDate(date) + ".jpg")
        
        let uiImage = UIImage(cgImage: cgImage)

        // Convert UIImage to Data
        if let data = uiImage.jpegData(compressionQuality: 1.0) {
            do {
                // Write the data to the file
                try data.write(to: fileURL)
                print("Image saved successfully")
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    // Helper function to format date as a string suitable for filenames
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        return formatter.string(from: date)
    }
    
    
    
    func retrieveImage(from date: Date) -> UIImage?{
        let filename = formatDate(date) + ".jpg"
        let fileURL = imagesDirectory.appendingPathComponent(filename)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL), let loadedImage = UIImage(data: imageData) {
                return loadedImage
            }
        }
        return nil
    }
    
//    func retrieveImage(from date: Date) async -> UIImage? {
//        let filename = formatDate(date) + ".jpg"
//        let fileURL = imagesDirectory.appendingPathComponent(filename)
//        
//        if FileManager.default.fileExists(atPath: fileURL.path) {
//            guard let imageData = try? await withCheckedThrowingContinuation({ continuation in
//                DispatchQueue.global().async {
//                    do {
//                        let data = try Data(contentsOf: fileURL)
//                        continuation.resume(returning: data)
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                }
//            })
//            else {
//                return nil
//            }
//            return DispatchQueue.global().sync {
//                UIImage(data: imageData)
//            }
//        } else {
//            return nil
//        }
//    }
}
