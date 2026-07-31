import SwiftUI

struct ContentView: View {

    @State private var showHome = true

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
                }
        }
    }
}

#Preview {
    ContentView()
}
