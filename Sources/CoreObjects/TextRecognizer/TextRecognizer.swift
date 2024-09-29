//
//  TextRecognizer.swift
//
//
//  Created by Алексей Филиппов on 28.09.2024.
//

// Apple
import UIKit

protocol TextRecognizer {
    func recognizeCashbackCategories(from image: UIImage,
                                     completion: @escaping ([String]) -> Void)
}
