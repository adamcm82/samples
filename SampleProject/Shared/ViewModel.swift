//
//  ViewModel.swift
//  SampleProject
//
//  Created by Adam on 6/18/22.
//

import CoreData
import SwiftUI
import Combine

class CoreDataViewModel: ObservableObject {
    
    static let instance = CoreDataViewModel()
    let container: NSPersistentCloudKitContainer
    @Published var savedLists: [ListEntity] = []
    
    init(){
        container = NSPersistentCloudKitContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        fetchLists()
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    //    MARK: Fetch List
    
    func fetchLists() {
        
        var returnedList: [ListEntity] = []
        
        let request = NSFetchRequest<ListEntity>(entityName: "ListEntity")
        
        do {
            returnedList = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch: \(error)")
        }
        savedLists = returnedList
        
    }
    
    //    MARK: Save
    func saveObject() {
        let context = container.viewContext
        
        do {
            try context.save()
        } catch {
        }
    }
    
    @Published var newListName: String = ""
    
    //    MARK: New List
    func addNewList() {
        let newList = ListEntity(context: container.viewContext)
        newList.name = newListName
        
        newListName = ""
        saveObject()
        
        fetchLists()
    }
    
    @Published var newItemName: String = ""
    
    //    MARK: New Item
    func addNewItem (currentList: ListEntity) {
        let newItem = ItemEntity(context: container.viewContext)
        newItem.name = newItemName
        newItem.assignedList = currentList
        
        newItemName = ""
        saveObject()
        
        fetchLists()
    }
    
    
    //    MARK: Delete List
    func deleteListObject(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedLists[index]
        container.viewContext.delete(entity)
        saveObject()
        self.fetchLists()
        
    }
    
    
}


