//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    
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
                        self.placeOrder()
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
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Thank You!"), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("There was an issue encoding the order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("There was no data in the response. Error: \(error?.localizedDescription ?? "Unnown Error")")
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = """
                    Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) is on its way.
                    """
                self.showConfirmation = true
            } else {
                print("Invalid response from the server.")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
