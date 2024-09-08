//
//  ContactsFeature.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 08/09/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                return .none
            }
        }
    }
}
