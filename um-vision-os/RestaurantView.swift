import SwiftUI
import RealityKit
import RealityKitContent


struct RestaurantView: View {
    let restaurant: Restaurant
    @EnvironmentObject var viewModel: RestaurantsViewModel
    let genericRestaurantCopyText : String = "is looking forward to serving you today, from our range of tasty dishes!"
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var showBurger = false
    @State private var showPizza = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State var pizzaBtnText:String = "See the Pizza"
    @State var burgerBtnText:String = "See the Burger"
    
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
                    HStack{
                        HStack{
                            Image(systemName: viewModel.isOpenDict[restaurant.id, default: false] ? "door.right.hand.open" : "door.right.hand.closed")
                                .foregroundStyle(viewModel.isOpenDict[restaurant.id, default: false] ? .white : .secondary)
                            
                            Text("\(viewModel.isOpenDict[restaurant.id, default: false] ? "Open" : "Closed")")
                                .foregroundStyle(viewModel.isOpenDict[restaurant.id, default: false] ? .white : .secondary)
                        }
                        .font(.system(size: 18))
                        .padding(.trailing, 24)
                        
                        HStack{
                            Image(systemName: "stopwatch")
                                
                            Text("\(restaurant.deliveryTime) mins")
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(.secondary)
                        .font(.system(size: 18))
                        .padding(.trailing, 24)
                        
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(String(format: "%.1f", restaurant.rating))")
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.white))
                        }
                    }
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
                            
                            if(showBurger){
                                openWindow(id: "burger-view")
                            }
                            else{
                                dismissWindow(id: "burger-view")
                            }
                            
                            burgerBtnText = showBurger ? "Hide the Burger" : "See the Burger"
                        }, label: {
                            Text(burgerBtnText)
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .padding(10.0)
                        })
                        .padding(16.0)
                    }
                    
                    if(restaurant.name == "Pizzeria Varsha"){
                        Button(action: {
                            showPizza.toggle()
                            pizzaBtnText = showPizza ? "Hide the Pizza" : "See the Pizza"
                        }, label: {
                            Text(pizzaBtnText)
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .padding(10.0)
                        })
                        .padding(16.0)
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

