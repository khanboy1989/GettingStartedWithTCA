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
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature() // Can be left empty but actions won't trigger
        ._printChanges() // Prints changes on state (if we have multiple changes it will only print the changed state variables)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: GettingStartedWithTCAApp.store)
        }
    }
}
