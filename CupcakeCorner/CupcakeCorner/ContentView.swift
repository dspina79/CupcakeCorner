import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if (order.specialRequestEnabled) {
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Sprinkes")
                        }
                        Toggle(isOn: $order.extraFrosting) {
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
