//
//  ListSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ListSelection: View {
    @EnvironmentObject var modelData: ModelData
    @State private var addSheet: Bool = false
    @State private var editSheet: Bool = false
    @State private var draftList: CheckList = CheckList.default
    
    var body: some View {
        
        let pinnedList = modelData.checkLists.filter{ $0.isPinned }
        let unPinnedList = modelData.checkLists.filter{ !$0.isPinned }
        
        NavigationView {
            Form{
            List{
                
                ///Showing all the available pinned List
                if pinnedList.count > 0 {
                    Section(header: Text("Pinned")) {
                        
                        ForEach(pinnedList){ checkList in
                            NavigationLink(
                                destination: ItemList(checkList: checkList).environmentObject(modelData),
                                tag: checkList.id,
                                selection: $modelData.listSelector
                            ){
                                ListRow(checkList: checkList)
                                    .environmentObject(modelData)
                            }
                        }
                        .onDelete { indexSet in
                            
                            ///removing Notifications
                            for i in indexSet {
                                for item in modelData.checkLists[i].items {
                                    AppNotification().remove(ID: item.id)
                                }
                            }
                            
                            modelData.checkLists.remove(atOffsets: indexSet)
                        }
                    }
                }
                
                ///Showing all the available Unpinned List
                Section{
                    
                    ForEach(unPinnedList){ checkList in
                        NavigationLink(
                            destination: ItemList(checkList: checkList).environmentObject(modelData),
                            tag: checkList.id,
                            selection: $modelData.listSelector
                        ){
                            ListRow(checkList: checkList)
                        }
                    }
                    .onDelete { indexSet in
                        
                        ///removing Notifications
                        for i in indexSet {
                            for item in modelData.checkLists[i].items {
                                AppNotification().remove(ID: item.id)
                            }
                        }
                        
                        modelData.checkLists.remove(atOffsets: indexSet)
                    }
                    
                    /// adding list button
                    Button{
                        withAnimation(.spring(dampingFraction: 0.25, blendDuration: 2)){
                            addSheet.toggle()
                        }
                        draftList = CheckList.default
                        
                    }label: {
                        Label("Add Item", systemImage: "plus")
                            .font(.body)
                            .foregroundColor(.accentColor)
                    }
                    .scaleEffect(addSheet ? 1.5 : 1)
                    .sheet(isPresented: $addSheet, content: {
                        ListInfo(showInfo: $addSheet, draftList: $draftList)
                            .environmentObject(modelData)
                    })
                }
            }
            }
            .navigationTitle("Lists")
        }
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
