//
//  AddPhotoView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/08/01.
//

import PhotosUI
import SwiftData
import SwiftUI

struct AddPhotoView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var label = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                } else {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedPhoto) { Task { await loadImage() } }
            
            if processedImage != nil {
                TextField("Label", text: $label)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical)
                
                Button("Save", action: { Task { await saveImage() } })
                    .buttonStyle(.borderedProminent)
                    .disabled(isValidLabel())
            }

        }
        .navigationTitle("Add a new photo")
        .padding()
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

#Preview {
    NavigationStack {
        AddPhotoView()
    }
}
