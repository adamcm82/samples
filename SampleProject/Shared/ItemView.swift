//
//  ItemView.swift
//  SampleProject
//
//  Created by Adam on 6/18/22.
//

import SwiftUI

struct ItemView: View {
    
    @ObservedObject var cdvm: CoreDataViewModel
    let currentList: ListEntity

    var body: some View {

        List {
            HStack {
                Image(systemName: "plus")
                    .onTapGesture {
                        cdvm.addNewItem(currentList: currentList)
                    }
                TextField("Add Here", text: $cdvm.newItemName)
            }
            
            ForEach(Array(currentList.assignedItems as! Set<ItemEntity>)) { savedItem in
                Text(savedItem.name ?? "")
            }
        }
        Spacer()
        .navigationTitle("Items in \(currentList.name ?? "")")
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(cdvm: <#CoreDataViewModel#>, currentList: <#ListEntity#>)
//    }
//}
