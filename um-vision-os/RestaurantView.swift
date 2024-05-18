import SwiftUI
import RealityKit
import RealityKitContent


struct RestaurantView: View {
    let restaurant: Restaurant
    let genericRestaurantCopyText : String = "is serving tasty delights for you, your friends and family. There is plenty on our delicious menu to try and treat yourself with. We look forward to serving you today!"
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var showBurger = false
    @State private var showPizza = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindowObject
    
    let foodNamesArr:[String] = ["Pizza","Burger"]
    
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
                    .padding(.vertical, 16.0)
                    
                    
                    if(restaurant.name == "Wayne \"Chad Broski\" Burgers"){
                        Button(action: {
                            showBurger.toggle()
                        }, label: {
                            Text("Show Burger")
                        })
                        .padding(16.0)
                    }
                    
                    if(restaurant.name == "Pizzeria Varsha"){
                        Button(action: {
                            showPizza.toggle()
                        }, label: {
                            Text("Show Pizza")
                        })
                        .padding(16.0)
                    }
                }
                
                if showBurger {
                    Model3D(named: "Burger") { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:800)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    //openWindowObject(id: "pizza-view")
                }
                
                if showPizza {
                    Model3D(named: "Pizza") { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:500)
                    } placeholder: {
                        ProgressView()
                    }
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
    
    
}

/*
#Preview {
    RestaurantView()
}
*/

