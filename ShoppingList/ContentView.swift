//
//  ContentView.swift
//  ShoppingList
//
//  Created by Fabian Braig on 09.07.21.
//

import SwiftUI


struct ContentView: View {

	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)])
	private var items: FetchedResults<Item>

    var body: some View {
		NavigationView {
			List {
				ForEach(items) { item in
					Text(item.title ?? "Untitled")
						.onTapGesture (count: 1, perform: {
							updateItem(item)
						})
				}
				.onDelete(perform: deleteItems)
			}
			.navigationTitle("Shopping List")
			.navigationBarItems(trailing: Button("Add Item") {
				addItem()
			})
		}
    }
    
    private func saveContext() {
		do {
			try viewContext.save()
		} catch {
			let error = error as NSError
			fatalError("Unresolved Error: \(error)")
		}
	}
    
    private func addItem() {
		withAnimation {
			let newItem = Item(context: viewContext)
			newItem.title = "New Item \(Date())"
			newItem.date = Date()
			saveContext()
		}
	}
	
	private func updateItem(_ item: FetchedResults<Item>.Element) {
		withAnimation {
			item.title = "Updated: " + Date().description
			item.date = Date()
			saveContext()
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map {items[$0]}.forEach(viewContext.delete)
			saveContext()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
