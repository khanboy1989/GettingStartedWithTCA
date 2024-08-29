//
//  GettingStartedWithTCAApp.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 28/08/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct GettingStartedWithTCAApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature() // Can be left empty but actions won't triggrr
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: GettingStartedWithTCAApp.store)
        }
    }
}
