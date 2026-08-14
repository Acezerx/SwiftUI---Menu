//
//  Menu.swift
//  Menu
//
//  Created by NCAdevice1 on 14/08/2026.
//

import SwiftUI

struct Menu: View {
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack(spacing: 20) {
                
                NavigationLink {
                    Food()
                } label: {
                    VStack {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 40))
                        
                        Text("Food")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(Color(.systemGray6))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                }
                
                NavigationLink {
                    Drinks()
                } label: {
                    VStack {
                        Image(systemName: "cup.and.saucer")
                            .font(.system(size: 40))
                        
                        Text("Drinks")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(Color(.systemGray6))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        Menu()
    }
}
