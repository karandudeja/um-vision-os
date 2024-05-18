import SwiftUI
import RealityKit
import RealityKitContent

struct StarterView: View {
    
    @EnvironmentObject var viewModel: RestaurantsViewModel
    
    @State private var selectedItem: Restaurant?
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.displayedRestaurants, selection: $selectedItem) { restaurant in
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
                    Toggle(isOn: $viewModel.topRatedToggle) {
                        FilterView(iconName: "icon-badge", iconLabel: "Top Rated", isOn: $viewModel.topRatedToggle)
                    }
                    .toggleStyle(.button)
                    .onChange(of: viewModel.topRatedToggle) {
                        viewModel.toggleTopRated()
                    }
                    
                    Spacer()
                    
                    Toggle(isOn: $viewModel.takeOutToggle) {
                        FilterView(iconName: "icon-coffee", iconLabel: "Take Away", isOn: $viewModel.takeOutToggle)
                    }
                    .toggleStyle(.button)
                    .onChange(of: viewModel.takeOutToggle) {
                        viewModel.toggleTakeOut()
                    }
                    
                    Spacer()
                    
                    Toggle(isOn: $viewModel.fastDeliveryToggle) {
                        FilterView(iconName: "icon-clock", iconLabel: "Fast Delivery", isOn: $viewModel.fastDeliveryToggle)
                    }
                    .toggleStyle(.button)
                    .onChange(of: viewModel.fastDeliveryToggle) {
                        viewModel.toggleFastDelivery()
                    }
                }
                .padding(8)
            })
        }
        
    }
}


/*
#Preview {
    StarterView()
}
*/

