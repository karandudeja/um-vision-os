import SwiftUI
import RealityKit
import RealityKitContent
import SceneKit

struct RestaurantView: View {
    let restaurant: Restaurant
    let genericRestaurantCopyText : String = "is serving tasty delights for you, your friends and family. There is plenty on our delicious menu to try and treat yourself with. We look forward to serving you today!"
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var showPizza = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: restaurant.imageUrl)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(height: 250)
                     .clipShape(Rectangle())
                     .clipped()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                HStack{
                    Text(restaurant.name)
                        .bold()
                        .font(.title)
                    Spacer()
                }
                
                HStack{
                    Text("Top-Rated & Fast Delivery & Take Away")
                        .fontWeight(.medium)
                        .font(.title3)
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.1f", restaurant.rating))")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.white))
                }
                .padding(.vertical, 8.0)
                
                HStack{
                    Text("\(restaurant.name) \(genericRestaurantCopyText)")
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                }
                .padding(.vertical, 8.0)
                
                HStack{
                    Button(action: {
                
                        showImmersiveSpace.toggle()
                            
                        Task {
                            if showImmersiveSpace {
                                switch await openImmersiveSpace(id: "ImmersiveSpace") {
                                case .opened:
                                    immersiveSpaceIsShown = true
                                case .error, .userCancelled:
                                    fallthrough
                                @unknown default:
                                    immersiveSpaceIsShown = false
                                    showImmersiveSpace = false
                                }
                            } else if immersiveSpaceIsShown {
                                await dismissImmersiveSpace()
                                immersiveSpaceIsShown = false
                            }
                        }
                    }, label: {
                        Text("Immersive Restaurant View")
                    })
                    .padding()
                    
                    
                    Button(action: {
                        showPizza.toggle()
                    }, label: {
                        Text("Show Pizza")
                    })
                    .padding()
                }
                
                if showPizza {
                    /*Model3D(named: "3DModels/Pizza") { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width:300, height: 300)*/
                    
                    SceneView(
                        scene: loadPizzaScene(),
                        options: [.autoenablesDefaultLighting, .allowsCameraControl]
                    )
                    .frame(height: 100)
                }
                
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 16.0)
            Spacer()
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadPizzaScene() -> SCNScene {
        guard let scene = SCNScene(named: "3DModels/Pizza.scn") else {
            print("Failed to load Pizza.scn")
            return SCNScene() // Return an empty scene if loading fails
        }
        return scene
    }
}

/*
#Preview {
    RestaurantView()
}
*/

