//
//  Details.swift
//  Menu
//
//  Created by NCAdevice1 on 12/08/2026.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var menuData: MenuData
    
    @State private var showOrderConfirmed = false
    @State private var showClearCartAlert = false
    
    var totalPrice: Double {
        menuData.cart.values.reduce(0) {
            $0 + ($1.item.price * Double($1.quantity))
        }
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                
                if menuData.cart.isEmpty && menuData.confirmedOrders.isEmpty {
                    
                    Spacer()
                    
                    Image(systemName: "cart")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                } else {
                    
                    List {
                        ForEach(
                            Array(menuData.confirmedOrders.enumerated()),
                            id: \.offset
                        ) { index, order in
                            
                            Section("Order \(index + 1)") {
                                
                                ForEach(
                                    Array(order.items.enumerated()),
                                    id: \.offset
                                ) { _, cartItem in
                                    
                                    HStack(spacing: 15) {
                                        
                                        Image(cartItem.item.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                            .opacity(0.45)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            Text(cartItem.item.title)
                                                .font(.headline)
                                            
                                            Text("Quantity: \(cartItem.quantity)")
                                                .foregroundColor(.gray)
                                            
                                            Text(
                                                String(
                                                    format: "€%.2f each",
                                                    cartItem.item.price
                                                )
                                            )
                                            .foregroundColor(.gray)
                                        }
                                        .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Text(
                                            String(
                                                format: "€%.2f",
                                                cartItem.item.price *
                                                Double(cartItem.quantity)
                                            )
                                        )
                                        .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 5)
                                }
                                
                                HStack {
                                    Text("Order Total")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                    Text(
                                        String(
                                            format: "€%.2f",
                                            order.total
                                        )
                                    )
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                }
                            }
                        }
                        if !menuData.cart.isEmpty {
                            
                            Section("Current Order") {
                                
                                ForEach(
                                    Array(menuData.cart.values),
                                    id: \.item.id
                                ) { cartItem in
                                    
                                    HStack(spacing: 15) {
                                        
                                        Image(cartItem.item.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            Text(cartItem.item.title)
                                                .font(.headline)
                                            
                                            Text(
                                                String(
                                                    format: "€%.2f each",
                                                    cartItem.item.price
                                                )
                                            )
                                            .foregroundColor(.gray)
                                            
                                            Text(
                                                "Quantity: \(cartItem.quantity)"
                                            )
                                            .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 10) {
                                            
                                            Button {
                                                if cartItem.quantity > 1 {
                                                    menuData.updateQuantity(
                                                        item: cartItem.item,
                                                        quantity: cartItem.quantity - 1
                                                    )
                                                }
                                            } label: {
                                                Image(
                                                    systemName:
                                                        "minus.circle.fill"
                                                )
                                                .font(.title2)
                                            }
                                            .buttonStyle(.borderless)
                                            
                                            Text("\(cartItem.quantity)")
                                                .font(.headline)
                                                .frame(minWidth: 25)
                                            
                                            Button {
                                                menuData.updateQuantity(
                                                    item: cartItem.item,
                                                    quantity: cartItem.quantity + 1
                                                )
                                            } label: {
                                                Image(
                                                    systemName:
                                                        "plus.circle.fill"
                                                )
                                                .font(.title2)
                                            }
                                            .buttonStyle(.borderless)
                                            
                                            Button {
                                                menuData.removeFromCart(
                                                    item: cartItem.item
                                                )
                                            } label: {
                                                Image(systemName: "trash")
                                                    .font(.title3)
                                                    .foregroundColor(.red)
                                            }
                                            .buttonStyle(.borderless)
                                            .padding(.leading, 8)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                                
                                HStack {
                                    Text("Total")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text(
                                        String(
                                            format: "€%.2f",
                                            totalPrice
                                        )
                                    )
                                    .font(.title2)
                                    .fontWeight(.bold)
                                }
                                .padding(.vertical, 10)
                                
                                Button {
                                    menuData.confirmOrder()
                                    
                                    withAnimation(
                                        .spring(
                                            response: 0.4,
                                            dampingFraction: 0.7
                                        )
                                    ) {
                                        showOrderConfirmed = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(
                                        deadline: .now() + 1.5
                                    ) {
                                        withAnimation(
                                            .easeOut(duration: 0.3)
                                        ) {
                                            showOrderConfirmed = false
                                        }
                                    }
                                } label: {
                                    Text("Confirm Order")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            if showOrderConfirmed {
                VStack(spacing: 12) {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 55))
                        .foregroundColor(.green)
                    
                    Text("Order Confirmed")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 25)
                .background(.regularMaterial)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .shadow(radius: 15)
                .transition(
                    .scale(scale: 0.7)
                    .combined(with: .opacity)
                )
            }
        }
        
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                if !menuData.cart.isEmpty {
                    
                    Button("Clear Cart") {
                        showClearCartAlert = true
                    }
                    
                } else if !menuData.confirmedOrders.isEmpty {
                    
                    Button("Clear Orders") {
                        showClearCartAlert = true
                    }
                }
            }
        }
        
        .alert(
            menuData.cart.isEmpty
                ? "Clear Orders?"
                : "Clear Cart?",
            isPresented: $showClearCartAlert
        ) {
            
            Button("Cancel", role: .cancel) {
            }
            
            Button("Clear", role: .destructive) {
                
                if !menuData.cart.isEmpty {
                    menuData.cart.removeAll()
                } else {
                    menuData.confirmedOrders.removeAll()
                }
                
            }
            
        } message: {
            
            if !menuData.cart.isEmpty {
                Text("This will remove all items from your current cart.")
            } else {
                Text("This will remove all of your confirmed orders.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject(MenuData())
    }
}
