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
    @Query var photos: [LabelledPhoto]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(photos) { photo in
                    Text(photo.label)
                }
                .onDelete(perform: deletePhoto)
            }
            .listStyle(.plain)
            .navigationTitle("Photo Library")
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
