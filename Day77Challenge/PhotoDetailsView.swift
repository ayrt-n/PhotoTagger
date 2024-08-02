//
//  PhotoDetailsView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/08/02.
//

import SwiftUI

struct PhotoDetailsView: View {
    var photo: LabelledPhoto
    
    var body: some View {
        VStack {
            if let image = photo.image {
                image
                    .resizable()
                    .scaledToFit()
            }
            
            Text(photo.label)
        }
        .navigationTitle("More details")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        
        Spacer()
    }
}

#Preview {
    Text("Not implemented")
}
