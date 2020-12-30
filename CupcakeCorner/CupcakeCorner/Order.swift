//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import Foundation

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case quantity, type, addSprinkles, extraFrosting,
             name, streetAddress, city, zip
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    
    @Published var quantity: Int = 3
    @Published var type: Int = 0
    @Published var addSprinkles = false
    @Published var extraFrosting = false
    @Published var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                self.addSprinkles = false
                self.extraFrosting = false
            }
        }
    }
    
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var formattedAddress: String {
        return "\(name)\n\(streetAddress)\n\(city) - \(zip)"
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2.00
        cost += Double(type) / 2.00
        
        if extraFrosting {
            cost += Double(quantity) / 2.00
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2.00
        }
        
        return cost
    }
    
    init() {
        // default initializer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try container.decode(Int.self, forKey: .quantity)
        type = try container.decode(Int.self, forKey: .type)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        
        specialRequestEnabled = addSprinkles || extraFrosting
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}
