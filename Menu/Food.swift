//
//  Food.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Food: View {
    
    @EnvironmentObject var menuData: MenuData
    
    let food = [
        MenuItem(
            image: "burger",
            title: "Burger",
            subtitle: "Juicy grilled beef burger",
            description: "A juicy grilled beef burger served with fresh toppings and a delicious combination of flavors.",
            price: 8.50
        ),
        
        MenuItem(
            image:"pizza",
            title:"Pizza",
            subtitle:"Oven baked pizza",
            description: "A freshly prepared pizza baked in the oven with a crispy crust and delicious toppings.",
            price: 15.99
            ),
        
        MenuItem(
            image:"pasta",
            title:"Pasta",
            subtitle:"Fresh homemade pasta",
            description: "Fresh homemade pasta prepared with quality ingredients and served with a flavorful sauce.",
            price: 13.99
        ),
        
        MenuItem(
            image:"salad",
            title:"Salad",
            subtitle:"Localy sourced ingredients",
            description: "A fresh and healthy salad made with locally sourced vegetables and carefully selected ingredients.",
            price: 6.99
        ),
        
        MenuItem(
            image:"soup",
            title:"Soup",
            subtitle:"Daily made",
            description: "A warm and comforting soup prepared fresh every day using carefully selected ingredients.",
            price: 9.99
        ),
        
        MenuItem(
            image:"fish",
            title:"Grilled Fish",
            subtitle:"Chefs-specialty",
            description: "Fresh fish grilled to perfection and seasoned with a selection of herbs and spices.",
            price: 18.99
        ),
        
        MenuItem(
            image:"dessert",
            title:"Desserts",
            subtitle:"Sweet treats and cakes",
            description: "A delicious selection of sweet treats and cakes, perfect for finishing your meal.",
            price: 11.99
        )
        
        
    ]
    
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(food) { item in
                    
                    NavigationLink {
                        Details(item: item)
                    } label: {
                        Rows(
                            image: item.image,
                            title: item.title,
                            subtitle: item.subtitle,
                            price: item.price
                        
                    
                        )
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CartView()
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.title2)
                            
                            if menuData.cartCount > 0 {
                                Text("\(menuData.cartCount)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(minWidth: 18, minHeight: 18)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Food()
}
