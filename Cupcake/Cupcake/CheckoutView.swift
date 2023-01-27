//
//  CheckoutView.swift
//  Cupcake
//
//  Created by Vinay Kumar Thapa on 2023-01-27.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confimationMessage = ""
    @State private var showingConfimation = false
    
    var body: some View {
        
        ScrollView{
            
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }placeholder: {
                    ProgressView()
                }.frame(height: 250)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))").font(.title)
                
                Button("Place Order", action: {
                    Task{
                        await placeOrder()
                    }
                    
                }).padding()
                
            }
            
            
        }.navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!",isPresented: $showingConfimation) {
                Button("OK") { }
            }message: {
                Text(confimationMessage)
            }
        
    }
    
    func placeOrder() async {
        
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode the order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //handle the result
            let decodedData = try? JSONDecoder().decode(Order.self, from: data)
            confimationMessage = "Your order for \(decodedData!.quantity) \(Order.cakeTypes[decodedData!.type].lowercased()) cupcakes is on its way"
            showingConfimation = true
                  
            
        }catch{
            print("Check out failed")
        }
        
        
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
