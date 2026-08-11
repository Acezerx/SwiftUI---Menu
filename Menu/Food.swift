//
//  Food.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Food: View {
    
    let food = [
        MenuItem(
            image: "burger",
            title: "Burger",
            subtitle: "Juicy grilled beef burger",
            description: "A juicy grilled beef burger served with fresh toppings and a delicious combination of flavors."
        ),
        
        MenuItem(
            image:"pizza",
            title:"Pizza",
            subtitle:"Oven baked pizza",
            description: "A freshly prepared pizza baked in the oven with a crispy crust and delicious toppings."
            ),
        
        MenuItem(
            image:"pasta",
            title:"Pasta",
            subtitle:"Fresh homemade pasta",
            description: "Fresh homemade pasta prepared with quality ingredients and served with a flavorful sauce."
        ),
        
        MenuItem(
            image:"salad",
            title:"Salad",
            subtitle:"Localy sourced ingredients",
            description: "A fresh and healthy salad made with locally sourced vegetables and carefully selected ingredients."
        ),
        
        MenuItem(
            image:"soup",
            title:"Soup",
            subtitle:"Daily made",
            description: "A warm and comforting soup prepared fresh every day using carefully selected ingredients."
        ),
        
        MenuItem(
            image:"fish",
            title:"Grilled Fish",
            subtitle:"Chefs-specialty",
            description: "Fresh fish grilled to perfection and seasoned with a selection of herbs and spices."
        ),
        
        MenuItem(
            image:"dessert",
            title:"Desserts",
            subtitle:"Sweet treats and cakes",
            description: "A delicious selection of sweet treats and cakes, perfect for finishing your meal."
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
                        
                    
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    Food()
}
