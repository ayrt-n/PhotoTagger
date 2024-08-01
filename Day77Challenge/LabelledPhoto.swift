//
//  LabelledPhoto.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/07/31.
//

import Foundation
import SwiftData

@Model
class LabelledPhoto {
    @Attribute(.externalStorage) var imageData: Data
    var label: String
    
    init(imageData: Data, label: String) {
        self.imageData = imageData
        self.label = label
    }
}
