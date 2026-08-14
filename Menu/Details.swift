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
    @State private var quantity = 1
    @State private var showCart = false
    
    var body: some View {
        ScrollView {
            VStack (spacing:10){
                
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                HStack (spacing:30){
                    Text(item.title)
                        .font(.largeTitle)
    
                    
                
                    HStack(spacing: 25) {
                        
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        } label: {
                            Image(systemName: "minus")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Text("\(quantity)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(minWidth: 30)
                        
                        Button {
                            quantity += 1
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                HStack(spacing: 20) {
                    Text(item.subtitle)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(String(format: "€%.2f", item.price))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Text(item.description)
                    .font(Font.body.monospacedDigit())
                    .multilineTextAlignment(.center)
                
                Button {
                    menuData.addToCart(
                        item: item,
                        quantity: quantity
                    )
                    quantity = 1
                } label: {
                    Text("Order")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal)
                
                Spacer()
                
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
            
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showCart = true
                } label: {
                    ZStack(alignment: .topTrailing) {
                        
                        Image(systemName: "cart")
                            .font(.title2)
                        
                        if menuData.cartCount > 0 {
                            Text("\(menuData.cartCount)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showCart) {
            CartView()
        }
    }
        
}

#Preview {
    Details(
        item: MenuItem(
            image: "coffee",
            title: "Coffee",
            subtitle: "Energetic boost",
            description: "A warm and flavorful drink.",
            price: 10.99
        )
    )
    .environmentObject(MenuData())
}
