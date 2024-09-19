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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.selectedTab, send: AppFeature.Action.selectedTab)) {
                CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                    .tabItem {
                        Text("Counter 1")
                    }.tag(AppFeature.Tab.tab1)
                
                CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                    .tabItem {
                        Text("Counter 2")
                    }.tag(AppFeature.Tab.tab2)
            }
        }
        
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}

/*
 To compose the CounterFeature into the AppFeature we can use the Scope reducer. It allows you to focus in on a sub-domain of the parent feature, and run a child reducer on that sub-domain. In this case we want to do that twice. First we single out the tab1 state and actions in order to run the CounterFeature reducer, and then we do it again for the tab2 state and actions.
 */
@Reducer
struct AppFeature {
    
    enum Tab {
        case tab1
        case tab2
    }
    
    // Composing State
    @ObservableState
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
        var selectedTab: AppFeature.Tab = .tab2
    }
    
    // Composing Action
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
        case selectedTab(AppFeature.Tab)
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
                state.selectedTab = .tab1
                print("Tab 1 is active")
                return .none
                
            case .tab2:
                state.selectedTab = .tab2
                print("Tab 2 is active")
                return .none
                
            case .selectedTab(let tab):
                state.selectedTab = tab
                print("Active tab: \(tab)")
                return .none
            }
        }
    }
}


