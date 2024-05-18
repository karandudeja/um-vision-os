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
                        .fontWeight(.semibold)
                        .font(.extraLargeTitle2)
                    Spacer()
                }
                
                HStack{
                    if !restaurant.filters.isEmpty {
                        ForEach(Array(restaurant.filters.enumerated()), id: \.element.id) { index, filter in
                            Text(filter.name + (index == restaurant.filters.count - 1 ? "" : " •"))
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                                .font(.system(size: 18))
                        }
                    }
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.1f", restaurant.rating))")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.white))
                }
                .padding(.vertical, 8.0)
                
                HStack{
                    Text("\(restaurant.name) \(genericRestaurantCopyText)")
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                        .lineSpacing(6.0)
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
                        Text("Restaurant View")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .padding(10.0)
                    })
                    .padding(.vertical, 16.0)
                    
                    
                    if(restaurant.name == "Wayne \"Chad Broski\" Burgers"){
                        Button(action: {
                            showBurger.toggle()
                        }, label: {
                            Text("Show Burger")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .padding(10.0)
                        })
                        .padding(16.0)
                    }
                    
                    if(restaurant.name == "Pizzeria Varsha"){
                        Button(action: {
                            showPizza.toggle()
                        }, label: {
                            Text("Show Pizza")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .padding(10.0)
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
                }
                
                if showPizza {
                    Model3D(named: "Pizza") { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:500, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    .rotation3DEffect(
                        .degrees(-12.0),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    
                    //openWindowObject(id: "pizza-view")
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

