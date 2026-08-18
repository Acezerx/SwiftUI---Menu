//
//  Drinks.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Drinks: View {
    
    @EnvironmentObject var menuData: MenuData
    
    let drinks = [
        MenuItem(
            image: "water",
            title: "Water",
            subtitle: "Nice and refreshing drink",
            description: "A refreshing and hydrating drink, perfect for any time of the day.",
            price: 0.99
        ),
        
        MenuItem(
            image: "coffee",
            title: "Coffee",
            subtitle: "Energetic boost",
            description: "A warm and flavorful drink that gives you an energetic boost.",
            price: 1.50
        ),
        
        MenuItem(
            image: "tea",
            title: "Tea",
            subtitle: "A nice cup of tea",
            description: "A comforting and relaxing drink, available in a variety of flavors.",
            price: 1.25
        ),
        
        MenuItem(
            image: "juice",
            title: "Juice",
            subtitle: "Freshly made juice",
            description: "Fresh and fruity, made to give you a naturally sweet and refreshing taste.",
            price: 2.55
        ),
        
        MenuItem(
            image: "soft-drink",
            title: "Soft Drink",
            subtitle: "Sugary boost to your day",
            description: "A cold, fizzy and sweet drink that's perfect for a refreshing break.",
            price: 2.10
        ),
        
        MenuItem(
            image: "alcohol",
            title: "Alcohol",
            subtitle: "Only the very best",
            description: "A selection of quality alcoholic beverages for those looking to enjoy a stronger drink.",
            price: 7.55
        ),
        
        MenuItem(
            image: "specials",
            title: "Daily Specials",
            subtitle: "A different surprise every day",
            description: "A special drink selected for today, offering something different and exciting every time.",
            price: 10.99
        )
    ]
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(drinks) { item in
                    
                    NavigationLink {
                        Details(item: item)
                    } label: {
                        Rows(
                            image: item.image,
                            title: item.title,
                            subtitle: item.subtitle,
                            price:
                                item.price
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
    Drinks()
}
