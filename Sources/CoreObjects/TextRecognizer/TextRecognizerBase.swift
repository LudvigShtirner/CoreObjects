//
//  TextRecognizerBase.swift
//
//
//  Created by Алексей Филиппов on 28.09.2024.
//

// Apple
import UIKit
import Vision

final class TextRecognizerBase {
    
}

extension TextRecognizerBase: TextRecognizer {
    // https://habr.com/ru/articles/840138/
    func recognizeCashbackCategories(from image: UIImage,
                                     completion: @escaping ([String]) -> Void) {
        guard let cgImage = image.cgImage else {
            completion([])
            return
        }
        let reuqestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (req, error) in
            guard let observations = req.results as? [VNRecognizedTextObservation] else {
                completion([])
                return
            }
            let detectedTexts: [String] = observations.compactMap {
                $0.topCandidates(1).first?.string
            }
            completion(detectedTexts)
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try reuqestHandler.perform([request])
            } catch {
                print("recognition handler error \(error.localizedDescription)")
            }
        }
    }
}
