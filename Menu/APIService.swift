//
//  APIService.swift
//  Menu
//
//  Created by NCAdevice1 on 09/08/2026.
//

import Foundation

class APIService {
    
    func fetchMeal(named name: String) async throws -> Meal {
        
        let encodedName = name.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )!
        
        let url = URL(
            string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(encodedName)"
        )!  
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(
            MealResponse.self,
            from: data
        )
        
        guard let meal = response.meals?.first else {
            throw URLError(.resourceUnavailable)
        }
        
        return meal
    }
}
