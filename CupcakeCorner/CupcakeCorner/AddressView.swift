//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: NewOrder
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderDetails.name)
                TextField("Address", text: $order.orderDetails.streetAddress)
                TextField("City", text: $order.orderDetails.city)
                TextField("Zip", text: $order.orderDetails.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check Out")
                }
            }.disabled(!order.orderDetails.hasValidAddress)
            
        }.navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: NewOrder())
    }
}
