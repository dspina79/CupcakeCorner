//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/28/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: NewOrder
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .accessibilityRemoveTraits(.isImage)
                        .frame(width: geo.size.width)
                        
                    
                    Text("Total cost for Order: $\(order.orderDetails.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    VStack {
                        Text("Shipping Information")
                            .font(.headline)
                        Text(order.orderDetails.formattedAddress)
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
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text(showError ? "Error" : "Thank You!"), message: Text(showError ? errorMessage: confirmationMessage), dismissButton: .default(Text(showError ? "Understood" : "Ok")))
            }
    }
    
    func placeOrder() {
        self.showError = false
        guard let encoded = try? JSONEncoder().encode(order) else {
            errorMessage = "There was an issue encoding the order"
            self.showError = true
            self.showConfirmation = true
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                errorMessage = "There was no data in the response. Error: \(error?.localizedDescription ?? "Unnown Error")"
                self.showError = true
                self.showConfirmation = true
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(NewOrder.self, from: data) {
                self.confirmationMessage = """
                    Your order for \(decodedOrder.orderDetails.quantity)x \(Order.types[decodedOrder.orderDetails.type].lowercased()) is on its way.
                    """
                self.showConfirmation = true
            } else {
                errorMessage =  "Invalid response from the server."
                self.showError = true
                self.showConfirmation = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: NewOrder())
    }
}
