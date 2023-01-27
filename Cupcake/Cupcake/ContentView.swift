//
//  ContentView.swift
//  Cupcake
//
//  Created by Vinay Kumar Thapa on 2023-01-27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    
    
    var body: some View {
        NavigationView{
            
            Form {
                Section{
                    Picker("Select the type of cake", selection: $order.type){
                        ForEach(Order.cakeTypes.indices){
                            Text(Order.cakeTypes[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Any Special Request?", isOn: $order.specialRequestEnabled.animation())
                
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    }label: {
                        Text("Add Delivery Details")
                    }
                }
                
                
            }.navigationTitle("Cupcake Order")
          
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
