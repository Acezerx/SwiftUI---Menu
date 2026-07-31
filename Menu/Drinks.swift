//
//  Drinks.swift
//  Menu
//
//  Created by NCAdevice1 on 24/07/2026.
//

import SwiftUI

struct Drinks: View {
    var body: some View {
        
        
        List
        {
            Rows(
                image: "water",
                title: "Water",
                subtitle: "Nice and refreshing drink"
            )
            
            Rows(
                image:"coffee",
                title:"Coffee",
                subtitle:"Energetic boost"
            )
            
            Rows(
                image:"tea",
                title:"Tea",
                subtitle:"A nice cup of tea"
            )
            
            Rows(
                image:"juice",
                title:"Juice",
                subtitle:"Freshly made juice"
            )
            
            Rows(
                image:"soft-drink",
                title:"Soft Drink",
                subtitle:"Sugary boost to your day"
            )
            
            Rows(
                image:"alcohol",
                title:"Alcohol",
                subtitle:"Only the very best"
            )
            
            Rows(
                image:"specials",
                title:"Daily Specials",
                subtitle:"A different surprise every day"
            )
            
        }
            
            
    }
}

#Preview {
    Drinks()
}
