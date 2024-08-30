//
//  CounterFeature.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 29/08/2024.
//

import ComposableArchitecture
import SwiftUI

// Reducer that keeps state and the actions
@Reducer
struct CounterFeature {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case resetButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .resetButtonTapped:
                state.count = 0
                return .none
            }
        }
    }
}


//Store is going to runtime of the feature (hold the state)
//Store is going to let the View observe the state and be notified whenever changes something in the store
/*
 •    Store: The core of TCA that holds your app’s state and handles actions.
 •    StoreOf: A type-safe way to create stores for specific features or modules.
 •    ViewStore: The interface between the Store and your SwiftUI views, allowing you to access state and dispatch actions within views.
 
 
 Why Can You Access viewStore.count Directly?
 
 This direct access is possible because ViewStore has a subscript method (often implemented as @dynamicMemberLookup) that allows you to access state properties directly. When you write viewStore.count, Swift looks for a count property in the State struct and provides it to you, thanks to the Equatable conformance and ViewStore’s ability to manage and observe state.
 */
struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("Reset") {
                        viewStore.send(.resetButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        
                        viewStore.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State()) {
        CounterFeature() // Can be left empty but actions won't triggrr
    })
}
