//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Total cost for Order: $\(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    VStack {
                        Text("Shipping Information")
                            .font(.headline)
                        Text(order.formattedAddress)
                    }.padding()
                    
                    Button("Place Order") {
                        // place order code here
                    }
                    .frame(width: 100, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.white, .orange, .white]), startPoint: .top, endPoint: .bottom))
                    .clipped()
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .padding(.top)
                }
            }
        }.navigationBarTitle("Checkout", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
