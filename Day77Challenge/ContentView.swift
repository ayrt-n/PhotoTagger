//
//  ContentView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/07/31.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \LabelledPhoto.label) var photos: [LabelledPhoto]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(photos) { photo in
                    NavigationLink(value: photo) {
                        HStack {
                            if let image = photo.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(15)
                            } else {
                                Text("Huh?")
                            }
                            Text(photo.label)
                        }
                    }
                }
                .onDelete(perform: deletePhoto)
            }
            .listStyle(.plain)
            .navigationTitle("Photo Library")
            .navigationDestination(for: LabelledPhoto.self) { photo in
                PhotoDetailsView(photo: photo)
            }
            .toolbar {
                NavigationLink("Add Photo") {
                    AddPhotoView()
                }
            }
        }
    }
    
    func deletePhoto(at offsets: IndexSet) {
        for offset in offsets {
            let photo = photos[offset]
            modelContext.delete(photo)
        }
    }
}

#Preview {
    ContentView()
}
