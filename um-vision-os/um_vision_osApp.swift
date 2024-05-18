import SwiftUI

@main
struct um_vision_osApp: App {
    
    @StateObject private var viewModel = RestaurantsViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            StarterView()
                .environmentObject(viewModel)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        
        WindowGroup(id: "pizza-view") {
            PizzaView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.3, height: 0.3, depth: 0.3, in:.meters)
    }
}
