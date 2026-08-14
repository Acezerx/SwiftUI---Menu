//
//  Details.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//


import SwiftUI

struct ContentView: View {

    @State private var showHome = true
    @StateObject private var menuData = MenuData()
    

    var body: some View {

        if showHome {

            Home(showHome: $showHome)

        } else {
            
                
                
                TabView {
                    
                    NavigationStack {
                            Menu()
                                    }.tabItem {
                                    Label("Menu", systemImage: "menucard")
                                }
                    
                    Camera()
                        .tabItem {
                            Label("Camera", systemImage: "camera")
                        }
                    Location()
                        .tabItem {
                            Label("Location",  systemImage:"location")
                                 }
                }.environmentObject(menuData)
        }
        
    }
}

#Preview {
    ContentView()
}
