//
//  ContactsView.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 08/09/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) {
                    contact in
                    
                    Text(contact.name)
                }
            }.navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            store.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(
        contacts: [
            Contact(id: UUID(), name: "Blob"),
            Contact(id: UUID(), name: "Blob Jr"),
            Contact(id: UUID(), name: "Blob Sr"),
        ]
    )) {
        ContactsFeature()
    })
}
