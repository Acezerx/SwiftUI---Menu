//
//  Rows.swift
//  Menu
//
//  Created by NCAdevice1 on 31/07/2026.
//

import SwiftUI

struct Rows: View {
    
    let image: String
    let title: String
    let subtitle: String
    
    
    var body: some View {
        
        
        HStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
