//
//  LabelledPhoto.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/07/31.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class LabelledPhoto {
    @Attribute(.externalStorage) var imageData: Data
    var label: String
    
    init(imageData: Data, label: String) {
        self.imageData = imageData
        self.label = label
    }
    
    var image: Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
}
