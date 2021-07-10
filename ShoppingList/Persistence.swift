//
//  Persistence.swift
//  ShoppingList
//
//  Created by Fabian Braig on 09.07.21.
//

import CoreData

struct PersistenceController {
	static let shared = PersistenceController()
	
	let container: NSPersistentContainer
	
	init() {
		container = NSPersistentContainer(name: "ShoppingList")
		
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error: \(error)")
			}
		}
	}
}
