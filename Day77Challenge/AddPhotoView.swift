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
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var label = ""
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        Form {
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .listRowInsets(EdgeInsets())
                        .cornerRadius(15)
                } else {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedPhoto) { Task { await loadImage() } }
            .listRowBackground(Color.clear)
            
            if processedImage != nil {
                Section {
                    TextField("Label", text: $label)
                }
            }
        }
        .onAppear(perform: locationFetcher.start)
        .navigationTitle("Add a new photo")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save", action: {
                Task {
                    await saveImage()
                    dismiss()
                }
            })
                .disabled(isValidLabel())
        }
    }
    
    func loadImage() async {
        if let loaded = try? await selectedPhoto?.loadTransferable(type: Data.self),
            let uiImage = UIImage(data: loaded) {
            processedImage = Image(uiImage: uiImage)
        } else {
            print("Failed")
        }
    }
    
    func saveImage() async {
        guard let imageData = try? await selectedPhoto?.loadTransferable(type: Data.self) else { return }
        
        let labelledPhoto = LabelledPhoto(imageData: imageData, label: label, location: locationFetcher.lastKnownLocation)
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
