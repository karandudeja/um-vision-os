import Foundation

struct Wrapper: Codable {
    let restaurants: [Restaurant]
}


struct Restaurant: Codable, Identifiable, Hashable {
    let id: String
    let imageUrl: String
    let deliveryTime: Int
    let name: String
    let rating: Double
    let filterIds: [String]
    
    //var filters: [RestaurantFilter] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case deliveryTime = "delivery_time_minutes"
        case name
        case rating
        case filterIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        deliveryTime = try container.decode(Int.self, forKey: .deliveryTime)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Double.self, forKey: .rating)
        filterIds = try container.decode([String].self, forKey: .filterIds)
    }
    
    init(id: String, imageUrl: String, deliveryTime: Int, name: String, rating: Double, filterIds: [String]) {
        self.id = id
        self.imageUrl = imageUrl
        self.deliveryTime = deliveryTime
        self.name = name
        self.rating = rating
        self.filterIds = filterIds
    }
    
    // Manually implement Equatable
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id &&
            lhs.imageUrl == rhs.imageUrl &&
            lhs.deliveryTime == rhs.deliveryTime &&
            lhs.name == rhs.name &&
            lhs.rating == rhs.rating &&
            lhs.filterIds == rhs.filterIds //&&
            //lhs.filters == rhs.filters
    }
    
    // Manually implement Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(imageUrl)
        hasher.combine(deliveryTime)
        hasher.combine(name)
        hasher.combine(rating)
        hasher.combine(filterIds)
        //hasher.combine(filters)
    }
}

struct RestaurantOpenCloseStatus: Codable, Identifiable {
    let id: String
    let isOpen: Bool
    
    enum CodingKeys2: String, CodingKey {
        case id = "restaurant_id"
        case isOpen = "is_currently_open"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys2.self)
        id = try container.decode(String.self, forKey: .id)
        isOpen = try container.decode(Bool.self, forKey: .isOpen)
    }
}

struct RestaurantFilter: Codable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
    }
}
