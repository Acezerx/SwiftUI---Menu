//
//  Home.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI



struct Home: View {
    
    @Binding var showHome: Bool
    
    var body: some View {
        ZStack(){
            Image("menu")
                .resizable()
                .scaledToFit()
                .frame(width:450)
                .ignoresSafeArea()
            
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showHome = false
                }
            }
        }
        
        
                        }
                    }

#Preview {
    Home(showHome: .constant(true))
}
