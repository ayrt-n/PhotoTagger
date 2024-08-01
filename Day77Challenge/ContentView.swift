//
//  ContentView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/07/31.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var photos: [LabelledPhoto]
    
    var body: some View {
        NavigationStack {
            List(0..<3, id: \.self) { num in
                NavigationLink("\(num)") {
                    Text("\(num)")
                }
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
}

#Preview {
    ContentView()
}
