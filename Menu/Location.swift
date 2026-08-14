//
//  Location.swift
//  Menu
//
//  Created by NCAdevice1 on 14/08/2026.
//

import SwiftUI
import MapKit

struct Location: View {
    
    @StateObject private var locationManager = LocationManager()
    
    let restaurantLocation = CLLocationCoordinate2D(
        latitude: 42.0043,
        longitude: 21.4097
    )
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Text("Restaurant Location")
                .font(.title2)
                .fontWeight(.bold)
            
            Map {
                
                Marker(
                    "Our Restaurant",
                    coordinate: restaurantLocation
                )
                
                if let location = locationManager.location {
                    UserAnnotation()
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .padding(.horizontal)
            
            Text("FINKI, Skopje")
                .font(.headline)
            
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    Location()
}
