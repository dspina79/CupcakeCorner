//
//  NewOrder.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/30/20.
//

import Foundation

class NewOrder: Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case orderDetails
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var orderDetails: OrderDetails
    
    init () {
        // default constructor
        orderDetails = OrderDetails()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderDetails = try container.decode(OrderDetails.self, forKey: .orderDetails)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.orderDetails, forKey: .orderDetails)
    }
}
