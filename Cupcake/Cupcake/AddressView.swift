//
//  AddressView.swift
//  Cupcake
//
//  Created by Vinay Kumar Thapa on 2023-01-27.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        
        Form{
            Section{
                TextField("Your name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zipCode)
            }
            
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                }label: {
                    Text("Check out")
                }.disabled(order.hasValidAddress == false)
            }
        }.navigationTitle("Delivery Details")

    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
