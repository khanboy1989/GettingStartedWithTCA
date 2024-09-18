//
//  AppFeature.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 07/09/2024.
//

// Parent Feature:
// TabView that would hold the state and actions of childviews with scope
import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView(selection: store.binding(
            get: { $0 }, send: AppFeature.Action.setActiveTab)) {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Counter 1")
                }.tag(AppFeature.State.Tab.tab1)
            
            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Text("Counter 2")
                }.tag(AppFeature.State.Tab.tab2)
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}

@Reducer
struct AppFeature {
    
    // Composing State
    @ObservableState
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
        // Property to track the active tab
        var activeTab: Tab = .tab1
        
        enum Tab {
            case tab1
            case tab2
        }
    }
    
    // Composing Action
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
        case setActiveTab(State.Tab)
    }
    
    var body: some ReducerOf<Self> {
        /*
         Here it is important to understand that
         this scope logic works like a coordinator pattern,
         each Feature class has its own coordinator (Feature class) so that
         when we trigger a action from TAB1 it would trigger a related Feature class from the view
         if it is not implemented it would trigger an action from the parent feature (AppFeature).
         */
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        
        Reduce { state, action in
            // Core logic of the app feature
            
            switch action {
            case .tab1:
                state.activeTab = .tab1
                print("Tab 1 is active")
                
            case .tab2:
                state.activeTab = .tab2
                print("Tab 2 is active")
                
            case .setActiveTab(let tab):
                state.activeTab = tab
            }
            
            //            switch state {
            //            case .tab1:
            //                print("Tab 1")
            //            case .tab2:
            //                print("Tab 2")
            //            }
            return .none
        }
    }
}


