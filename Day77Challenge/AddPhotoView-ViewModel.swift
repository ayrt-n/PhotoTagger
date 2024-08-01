//
//  AddPhotoView-ViewModel.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/08/01.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI

extension AddPhotoView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        
        var selectedPhoto: PhotosPickerItem?
        var processedImage: Image?
        var label = ""
        
        init(modelContext: ModelContext, selectedPhoto: PhotosPickerItem? = nil, processedImage: Image? = nil, label: String = "") {
            self.modelContext = modelContext
            self.selectedPhoto = selectedPhoto
            self.processedImage = processedImage
            self.label = label
        }
        
        func loadImage() async {
            if let loaded = try? await selectedPhoto?.loadTransferable(type: Image.self) {
                processedImage = loaded
            } else {
                print("Failed")
            }
        }
        
        func saveImage() async {
            guard let imageData = try? await selectedPhoto?.loadTransferable(type: Data.self) else { return }
            
            let labelledPhoto = LabelledPhoto(imageData: imageData, label: label)
            modelContext.insert(labelledPhoto)
        }
        
        func isValidLabel() -> Bool {
            label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
}
