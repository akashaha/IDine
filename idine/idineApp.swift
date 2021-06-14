//
//  idineApp.swift
//  idine
//
//  Created by Arman Akash on 6/11/21.
//

import SwiftUI

@main
struct idineApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
