//
//  APIResponse.swift
//  Menu
//
//  Created by NCAdevice1 on 09/08/2026.
//

import Foundation


struct MealResponse: Codable{
    let meals: [Meal]?
}

struct Meal: Codable {
    
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
}


