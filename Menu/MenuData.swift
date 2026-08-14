//
//  Data.swift
//  Menu
//
//  Created by NCAdevice1 on 06/08/2026.
//

import Foundation
import Combine

struct CartItem {
    let item: MenuItem
    var quantity: Int
}

struct Order {
    let items: [CartItem]
    let total: Double
}

class MenuData: ObservableObject {
    
    @Published var confirmedOrders: [Order] = []
    
    @Published var comments: [String: [String]] = [:]
    
    @Published var cart: [String: CartItem] = [:]
    
    var cartCount: Int {
        cart.values.reduce(0) { $0 + $1.quantity }
    }
    
    func confirmOrder() {
        guard !cart.isEmpty else { return }
        
        let items = Array(cart.values)
        
        let total = items.reduce(0) {
            $0 + ($1.item.price * Double($1.quantity))
        }
        
        confirmedOrders.append(
            Order(
                items: items,
                total: total
            )
        )
        
        cart.removeAll()
    }
    
    func addToCart(item: MenuItem, quantity: Int) {
        if let existing = cart[item.id] {
            cart[item.id] = CartItem(
                item: item,
                quantity: existing.quantity + quantity
            )
        } else {
            cart[item.id] = CartItem(
                item: item,
                quantity: quantity
            )
        }
    }
    
    func removeFromCart(item: MenuItem) {
        cart.removeValue(forKey: item.id)
    }
    
    func updateQuantity(item: MenuItem, quantity: Int) {
        if quantity <= 0 {
            cart.removeValue(forKey: item.id)
        } else {
            cart[item.id] = CartItem(
                item: item,
                quantity: quantity
            )
        }
    }
}
