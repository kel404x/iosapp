//
//  z_1App.swift
//  z-1
//
//  
//

import SwiftUI

@main
struct z_1App: App {
    @StateObject var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GridView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
