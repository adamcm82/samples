//
//  ContentView.swift
//  Shared
//
//  Created by Adam on 6/18/22.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var cdvm: CoreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "plus")
                        .onTapGesture {
                            cdvm.addNewList()
                        }
                    TextField("Add Here", text: $cdvm.newListName)
                }
                
                ForEach(cdvm.savedLists) { savedList in
                    NavigationLink {
                        ItemView(cdvm: cdvm, currentList: savedList)
                    } label: {
                        Text(savedList.name ?? "")
                    }
                }
                .onDelete (perform: cdvm.deleteListObject)
            }
            Spacer()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
