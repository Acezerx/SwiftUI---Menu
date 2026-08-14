//
//  Details.swift
//  Menu
//
//  Created by NCAdevice1 on 06/08/2026.
//

import SwiftUI

struct Details: View {
    
    
    let item: MenuItem
    
    @State private var comment = ""
    @EnvironmentObject var menuData: MenuData
    @State private var meal: Meal?
    @State private var apiError = false
    
    
    var body: some View {
        ScrollView {
            VStack (spacing:10){
                
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                Text(item.title)
                    .font(.largeTitle)
                
                Text(item.subtitle)
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(item.description)
                    .font(Font.body.monospacedDigit())
                    .multilineTextAlignment(.center)
                
                TextField("Write a comment", text: $comment)
                    .textFieldStyle(.roundedBorder)
                Button("Add Comment") {
                    if !comment.isEmpty {
                        menuData.comments[item.id, default: []].append(comment)
                        comment = ""
                    }
                }
                
                ForEach(menuData.comments[item.id] ?? [], id: \.self) { comment in
                    Text(comment)
                    
                    
                }            }
            
            .padding()
            .task {
                do {
                    meal = try await APIService().fetchMeal(named: item.title)
                    print("API returned:", meal?.strMeal ?? "No meal")
                } catch {
                    print("API ERROR:", error)
                    apiError = true
                }
            }
            
            
            if let meal = meal {
                
                VStack(spacing: 8) {
                    
                    HStack(spacing: 6) {
                        Image(systemName: "globe")
                        
                        Text("From the Web")
                            .font(.headline)
                    }
                    
                    Text(meal.strMeal)
                        .font(.subheadline)
                        .bold()
                    
                    if let category = meal.strCategory {
                        Text("Category: \(category)")
                            .font(.subheadline)
                    }
                    
                    if let area = meal.strArea {
                        Text("Area: \(area)")
                            .font(.subheadline)
                    }
                }
                .frame(maxWidth: 320)
                .padding()
                .background(Color.gray.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.top, 15)
                
            } else if apiError {
                
                Text("No information available from the web service for this item.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
            }
            
        }
    }
        
}

#Preview {
    Details(
        item: MenuItem(
            image: "coffee",
            title: "Coffee",
            subtitle: "Energetic boost",
            description: "A warm and flavorful drink."
        )
    )
    .environmentObject(MenuData())
}
