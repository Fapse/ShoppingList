//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Fabian Braig on 09.07.21.
//

import SwiftUI

@main
struct ShoppingListApp: App {

	let persistenceContainer = PersistenceController.shared
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext,
					persistenceContainer.container.viewContext)
        }
    }
}
