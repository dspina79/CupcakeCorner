//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var quantity = 3
    @Published var type = 0
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
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
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
}
