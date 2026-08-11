import SwiftUI

struct ContentView: View {

    @State private var showHome = true
    @StateObject private var menuData = MenuData()
    

    var body: some View {

        if showHome {

            Home(showHome: $showHome)

        } else {
            
                
                
                TabView {
                    
                    Drinks()
                        .tabItem {
                            Label("Drinks", systemImage: "cup.and.saucer.fill")
                        }
                    
                    Food()
                        .tabItem {
                            Label("Food", systemImage: "fork.knife")
                        }
                }.environmentObject(menuData)
        }
        
    }
}

#Preview {
    ContentView()
}
