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
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        case deleteButtonTapped(id: Contact.ID)

    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
                
                /*
                 Child view dismissed it self so we don't need to implement this case
                 */
//            case .addContact(.presented(.delegate(.cancel))):
//                state.addContact = nil
//                return .none
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
//                state.addContact = nil // dismiss is handled by child feature
                return .none
            case .addContact:
                return .none
                
            case let .deleteButtonTapped(id):
                return .none 
            }
        }.ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}
