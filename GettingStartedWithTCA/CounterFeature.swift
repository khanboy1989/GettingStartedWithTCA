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
    @ObservableState
    struct State: Equatable {
        var count = 0
        var isLoading = false
        var fact: String?
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case resetButtonTapped
        case factButtonTapped
        case factResponse(String)
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .resetButtonTapped:
                state.count = 0
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run {/*Captures the count's current value before triggering the event*/ [count = state.count] send in
                    // ✅ Do async work in here, and send actions back into the system.
                    // 🛑 Mutable capture of 'inout' parameter 'state' is not allowed in
                    //    concurrently-executing code
                    // 🛑 'async' call in a function that does not support concurrency
                    // 🛑 Errors thrown from here are not handled
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
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
                
                Button("Fact") {
                    store.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                if store.isLoading {
                    ProgressView()
                } else if let fact = store.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
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
