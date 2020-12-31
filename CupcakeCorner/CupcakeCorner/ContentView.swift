import SwiftUI

struct ContentView: View {
    @ObservedObject var order = NewOrder()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderDetails.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.orderDetails.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderDetails.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderDetails.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if (order.orderDetails.specialRequestEnabled) {
                        Toggle(isOn: $order.orderDetails.addSprinkles) {
                            Text("Sprinkes")
                        }
                        Toggle(isOn: $order.orderDetails.extraFrosting) {
                            Text("Extra frosting")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationBarTitle(Text("Cupcake Corner"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
