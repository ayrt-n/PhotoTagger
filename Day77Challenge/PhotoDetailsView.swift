//
//  PhotoDetailsView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/08/02.
//

import MapKit
import SwiftData
import SwiftUI

struct PhotoDetailsView: View {
    var labelledPhoto: LabelledPhoto
    @State private var showLocation = false
    
    var body: some View {
        ScrollView {
            VStack {
                if let image = labelledPhoto.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                }
                
                Text(labelledPhoto.label)
                    .padding(.vertical)
                
                Picker("Show location?", selection: $showLocation) {
                    Text("Off").tag(false)
                    Text("On").tag(true)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                if showLocation {
                    MapView(location: labelledPhoto.coordinates)
                }
            }
        }
        .navigationTitle("More details")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LabelledPhoto.self, configurations: config)
    
    if let uiImage = UIImage(named: "example"),
       let imageData = uiImage.pngData() {
        let coord = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
        
        let exampleLabelledPhoto = LabelledPhoto(imageData: imageData, label: "Example Label", location: coord)
        
        return NavigationStack {
            PhotoDetailsView(labelledPhoto: exampleLabelledPhoto)
        }
        .modelContainer(container)
    } else {
        return Text("Not implemented")
    }
}
