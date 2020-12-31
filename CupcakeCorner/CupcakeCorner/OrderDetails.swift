//
//  OrderDetails.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/30/20.
//

import Foundation

struct OrderDetails: Codable {
    var quantity: Int = 3
    var type: Int = 0
    var addSprinkles = false
    var extraFrosting = false
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                self.addSprinkles = false
                self.extraFrosting = false
            }
        }
    }
    
    var name: String = ""
    var streetAddress: String = ""
    var city: String = ""
    var zip: String = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
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
