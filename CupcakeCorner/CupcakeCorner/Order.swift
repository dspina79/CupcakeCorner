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
}
