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
    }
}
