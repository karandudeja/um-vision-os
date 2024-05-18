import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchRestaurants() async throws -> [Restaurant] {
        let urlString = "https://food-delivery.umain.io/api/v1/restaurants"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        var restaurants = wrapper.restaurants
        
        
        for index in 0..<restaurants.count {
            if(!restaurants[index].filterIds.isEmpty){
                let filterDetails = try await fetchFiltersForRestaurant(restaurant: &restaurants[index])
                restaurants[index].filters = filterDetails
                
            }
        }
            
        return restaurants
        
    }
        
        
    func fetchFiltersForRestaurant(restaurant: inout Restaurant) async throws -> [RestaurantFilter] {
        var filters = [RestaurantFilter]()
        
        for filterId in restaurant.filterIds {
            let filter = try await fetchFilterDetails(filterId: filterId)
            filters.append(filter)
        }
        
        //print("test here .... ", filters)
        
        return filters
    }
        
        
    func fetchFilterDetails(filterId: String) async throws -> RestaurantFilter {
        let urlString = "https://food-delivery.umain.io/api/v1/filter/\(filterId)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(RestaurantFilter.self, from: data)
    }
        
        
        
    func fetchOpenClosedRestaurants(restaurantId: String) async throws -> Bool {
        let urlString = "https://food-delivery.umain.io/api/v1/open/\(restaurantId)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        //let status = try JSONDecoder().decode(OpenCloseStatus.self, from: data)
        let status = try JSONDecoder().decode(RestaurantOpenCloseStatus.self, from: data)
        return status.isOpen
    }
        
}





