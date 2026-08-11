//
//  Drinks.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Drinks: View {
    
    let drinks = [
        MenuItem(
            image: "water",
            title: "Water",
            subtitle: "Nice and refreshing drink",
            description: "A refreshing and hydrating drink, perfect for any time of the day."
        ),
        
        MenuItem(
            image: "coffee",
            title: "Coffee",
            subtitle: "Energetic boost",
            description: "A warm and flavorful drink that gives you an energetic boost."
        ),
        
        MenuItem(
            image: "tea",
            title: "Tea",
            subtitle: "A nice cup of tea",
            description: "A comforting and relaxing drink, available in a variety of flavors."
        ),
        
        MenuItem(
            image: "juice",
            title: "Juice",
            subtitle: "Freshly made juice",
            description: "Fresh and fruity, made to give you a naturally sweet and refreshing taste."
        ),
        
        MenuItem(
            image: "soft-drink",
            title: "Soft Drink",
            subtitle: "Sugary boost to your day",
            description: "A cold, fizzy and sweet drink that's perfect for a refreshing break."
        ),
        
        MenuItem(
            image: "alcohol",
            title: "Alcohol",
            subtitle: "Only the very best",
            description: "A selection of quality alcoholic beverages for those looking to enjoy a stronger drink."
        ),
        
        MenuItem(
            image: "specials",
            title: "Daily Specials",
            subtitle: "A different surprise every day",
            description: "A special drink selected for today, offering something different and exciting every time."
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
                            subtitle: item.subtitle
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    Drinks()
}
