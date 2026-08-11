//
//  Data.swift
//  Menu
//
//  Created by NCAdevice1 on 06/08/2026.
//

import Foundation
import Combine

class MenuData: ObservableObject {
    
    @Published var comments: [String: [String]] = [:]
}
