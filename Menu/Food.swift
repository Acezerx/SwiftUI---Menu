//
//  Food.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Food: View {
    var body: some View {
        
        List
        {
            Rows(
                image: "burger",
                title: "Burger",
                subtitle: "Juicy grilled beef burger"
            )
            
            Rows(
                image:"pizza",
                title:"Pizza",
                subtitle:"Oven baked pizza"
            )
            
            Rows(
                image:"pasta",
                title:"Pasta",
                subtitle:"Fresh homemade pasta"
            )
            
            Rows(
                image:"salad",
                title:"Salad",
                subtitle:"Localy sourced ingredients"
            )
            
            Rows(
                image:"soup",
                title:"Soup",
                subtitle:"Daily made"
            )
            
            Rows(
                image:"fish",
                title:"Grilled Fish",
                subtitle:"Chefs-specialty"
            )
            
            Rows(
                image:"dessert",
                title:"Desserts",
                subtitle:"Sweet treats and cakes"
            )
            
        }
        
        
    }
}

#Preview {
    Food()
}
