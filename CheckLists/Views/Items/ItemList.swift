//
//  ItemList.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemList: View {
	@EnvironmentObject var modelData: ModelData
	@State private var showInfo: Bool = false
    @State private var newItem: Bool = false
    @State private var draftItem: CheckList.Items = CheckList.Items.default
    @State private var showListInfo: Bool = false
    @State private var draftList: CheckList = CheckList.default
    
    var checkList: CheckList
    
    var body: some View {
        
        if let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id}) {
            
            let filteredItems = filterItems(checkList: modelData.checkLists[indexList])
            
            List(){
                ForEach(filteredItems) { item in
                    
                    HStack{
                        
                        /// Completed button
                        ToggleCompleted(item: item, indexList: indexList)
                            .environmentObject(modelData)
                        
                        /// Item name
                        ItemName(item: item)
                        
                        Spacer()
                        
                        /// quantity
                        if checkList.showQuantity {
                            
                            Text("\(item.itemQuantity)")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding()
                        }
                        
                        /// Flag icon
                        FlagItem(item: item, indexList: indexList)
                            .environmentObject(modelData)
                        
                        /// info button
                        AddInfoButton(showInfo: $showInfo, draftItem: $draftItem, checkList: checkList, item: item)
                        .sheet(isPresented: $showInfo) {
                            ItemInfo(showInfo: $showInfo, draftItem: $draftItem, indexList: indexList)
                                .environmentObject(modelData)

                        }
                        
                    }
                }
                /// Drag to delete
                .onDelete{ indexSet in
                    ///removing notification
                    for i in indexSet {
                        AppNotification().remove(ID: modelData.checkLists[indexList].items[i].id)
                    }
                    
                    modelData.checkLists[indexList].items.remove(atOffsets: indexSet)
                }
                
                /// new item button
                AddInfoButton(showInfo: $newItem, draftItem: $draftItem, checkList: checkList, item: CheckList.Items.default)
                .sheet(isPresented: $newItem) {
                    ItemInfo(showInfo: $newItem, draftItem: $draftItem, indexList: indexList)
                        .environmentObject(modelData)
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(checkList.listName)
            .foregroundColor(modelData.checkLists[indexList].color)
            .toolbar{
                /// Toolbar
                ItemListToolBar(showListInfo: $showListInfo, indexList: indexList)
                    .environmentObject(modelData)
            }
            
            /// List info sheet
            .sheet(isPresented: $showListInfo, content: {
                ListInfo(showInfo: $showListInfo, draftList: $draftList)
                    .environmentObject(modelData)
                    .onAppear(perform: {
                        draftList = modelData.checkLists[indexList]
                    })
            })
        }
    }
}

func filterItems(checkList: CheckList) -> [CheckList.Items] {
    if checkList.showCompleted {
        let completedList = checkList.items.filter{ (!$0.isCompleted || !checkList.completedAtBottom) && $0.flagged} + checkList.items.filter{ (!$0.isCompleted || !checkList.completedAtBottom) && !$0.flagged }
        let incompleteList = checkList.items.filter{ ($0.isCompleted && checkList.completedAtBottom) && $0.flagged } + checkList.items.filter{ ($0.isCompleted && checkList.completedAtBottom) && !$0.flagged}
        return  completedList + incompleteList
    }else {
        return checkList.items.filter{ !$0.isCompleted && $0.flagged} + checkList.items.filter{ !$0.isCompleted && !$0.flagged}
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList(checkList: ModelData().checkLists[0])
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
