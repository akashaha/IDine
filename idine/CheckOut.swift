//
//  CheckOut.swift
//  idine
//
//  Created by Arman Akash on 6/13/21.
//

import SwiftUI

struct CheckOut: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    
    let paymentTypes = ["Cash","Credit Card", "iDine points"]
    let tipAmounts = [10,15,20,25,0]
    
    var totalPrice :  String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total/100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total+tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("How do you want to pay?", selection: $paymentType) {
                    
                    ForEach(paymentTypes, id : \.self){
                        Text($0)
                    }
                }
                
                Toggle("Add iDine loyalty card", isOn :
                        $addLoyaltyDetails.animation())
                if addLoyaltyDetails{
                TextField("Enter your iDine ID :", text: $loyltyNumber)
                }
            }
            
            Section(header: Text("Add a tip ?")){
                Picker("Persentage: ", selection : $tipAmount){
                    ForEach(tipAmounts, id: \.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Total : \(totalPrice)")
                        .font(.largeTitle)
            ){
                Button("Confirm Order"){
                    showingPaymentAlert.toggle()
                }
                
            }
            
        }.navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            // some code
            
            Alert(title: Text("Order Confirmed"), message: Text("Your total is \(totalPrice)"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckOut_Previews: PreviewProvider {
    static var previews: some View {
        CheckOut()
            .environmentObject(Order())
    }
}
