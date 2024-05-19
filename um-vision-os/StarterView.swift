import SwiftUI
import RealityKit
import RealityKitContent

struct StarterView: View {
    
    @EnvironmentObject var viewModel: RestaurantsViewModel
    
    @State private var selectedItem: Restaurant?
    
    @State var showSplashScreen : Bool = true
    @State var showToolbar : Bool = false
    
    var body: some View {
        ZStack{
            if showSplashScreen{
                SplashScreenView()
            }
            else{
                NavigationSplitView {
                    List(viewModel.displayedRestaurants, selection: $selectedItem) { restaurant in
                        Text(restaurant.name)
                            .font(.title)
                            .tag(restaurant)
                            .padding(.vertical, 10)
                            .onAppear {
                                Task {
                                    do {
                                        let status = try await viewModel.fetchOpenCloseStatus(restaurantId: restaurant.id)
                                        viewModel.isOpenDict[restaurant.id] = status
                                    } catch {
                                        print("Error fetching open/close status: \(error)")
                                    }
                                }
                            }
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
        
                .toolbar{
                    if showToolbar{
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
                        })
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadRestaurants()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3)
            {
                withAnimation{
                    self.showSplashScreen = false
                    self.showToolbar = true
                }
            }
        }
    }
}


/*
#Preview {
    StarterView()
}
*/

