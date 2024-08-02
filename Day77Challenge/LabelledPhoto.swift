//
//  LabelledPhoto.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/07/31.
//

import Foundation
import MapKit
import SwiftData
import SwiftUI

@Model
class LabelledPhoto {
    struct Coordinates: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    @Attribute(.externalStorage) var imageData: Data
    var label: String
    var location: Coordinates?
    
    init(imageData: Data, label: String, location: CLLocationCoordinate2D?) {
        self.imageData = imageData
        self.label = label
        
        if let coordinates = location  {
            self.location = Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude)
        } else {
            self.location = nil
        }
    }
    
    var image: Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
    
    var coordinates: CLLocationCoordinate2D? {
        if let latitude = location?.latitude, let longitude = location?.longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
}
