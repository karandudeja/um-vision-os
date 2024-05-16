import Foundation

@Observable
class RestaurantsViewModel: ObservableObject {
    var restaurants: [Restaurant] = []
    var displayedRestaurants: [Restaurant] = []
    var isLoading = false
    var error: Error?
    var isOpenDict: [String: Bool] = [:]
    var topRatedToggle = false
    var takeOutToggle = false
    var fastDeliveryToggle = false
    
    private let topRatedFilterID = "5c64dea3-a4ac-4151-a2e3-42e7919a925d"
    private let takeOutFilterID = "c67cd8a3-f191-4083-ad28-741659f214d7"
    private let fastDeliveryFilterID = "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"

    func loadRestaurants() {
        isLoading = true
        Task {
            do {
                restaurants = try await NetworkService.shared.fetchRestaurants()
                //funcFiltersAndSort()
                error = nil
            } catch let fetchError {
                print("Failed to fetch restaurants:", fetchError)
                self.error = fetchError
                self.restaurants = []
            }
            isLoading = false
        }
    }
    
    
    func funcFiltersAndSort() {
        var filtered = restaurants
        
        if topRatedToggle {
            filtered = filtered.filter { $0.filterIds.contains(topRatedFilterID) }
            filtered.sort { $0.rating > $1.rating }
        }
        
        if takeOutToggle {
            filtered = filtered.filter { $0.filterIds.contains(takeOutFilterID) }
        }
        
        if fastDeliveryToggle {
            filtered = filtered.filter { $0.filterIds.contains(fastDeliveryFilterID) }
            filtered.sort { $0.deliveryTime < $1.deliveryTime }
        }
        
        displayedRestaurants = filtered
    }
    
    func toggleTopRated() {
        topRatedToggle.toggle()
        print("Toggle Top Rated !!!!")
        funcFiltersAndSort()
    }

    func toggleTakeOut() {
        takeOutToggle.toggle()
        print("Toggle Take Out !!!")
        funcFiltersAndSort()
    }

    func toggleFastDelivery() {
        fastDeliveryToggle.toggle()
        print("Toggle Fast Deliver !!")
        funcFiltersAndSort()
    }
    
    
    func fetchOpenCloseStatus(restaurantId: String) async throws -> Bool {
        do {
            return try await NetworkService.shared.fetchOpenClosedRestaurants(restaurantId: restaurantId)
        } catch {
            throw error
        }
    }
}
