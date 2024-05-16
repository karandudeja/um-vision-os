import SwiftUI
import RealityKit
import RealityKitContent


struct StarterView: View {
    
    @EnvironmentObject var viewModel: RestaurantsViewModel
    
    @State private var selectedItem: Restaurant?
    
    var body: some View {
        NavigationSplitView {
            
            List(viewModel.restaurants, selection: $selectedItem) { restaurant in
                Text(restaurant.name)
                    .font(.title)
                    .tag(restaurant)
                    .padding(.vertical, 10)
            }
            .navigationTitle("Restaurants")
                
            
        } detail: {
            if let selected = selectedItem {
    
                RestaurantView(restaurant: selected)
                
            } else {
                Text("Select a Restaurant")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .offset(y:-50)
            }
        }
        .onAppear {
            viewModel.loadRestaurants()
        }
        .toolbar{
            ToolbarItem(placement: .bottomOrnament, content: {
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.red)
                    })
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    })
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                    })
                }
            })
        }
        
    }
}


/*
#Preview {
    StarterView()
}
*/

