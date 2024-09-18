//
//  CounterView.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 08/09/2024.
//

import SwiftUI
import ComposableArchitecture

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
    
    /* Currently it is not necessary to use withViewStore because @ObservableState is the new way of listening State changes */
    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(store.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        store.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("Reset") {
                        store.send(.resetButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        store.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                    store.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
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
//        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State()) {
        CounterFeature() // Can be left empty but actions won't trigger
    })
}
