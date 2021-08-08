//
//  ItemToolBar.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ItemToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var draftItem: CheckList.Items
    @Binding var showInfo: Bool
    
    var indexList: Int
    
    var body: some View {
        HStack {
            
            ///Cancel Button
            Button{
                showInfo = false
                draftItem = CheckList.Items.default
                
            }label:{
                Text("Cancel")
            }
            
            Spacer()
            
            ///Done button
            Button{
                showInfo = false
                
                if (draftItem.id == CheckList.Items.default.id && draftItem.itemName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                    
                    draftItem.id = UUID()
                    ///adding new Item to the list
                    modelData.checkLists[indexList].items.append(draftItem)
                    
                }else if draftItem.id != CheckList.Items.default.id {
                    ///Changing the data of item if it already existed
                    let index: Int = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == draftItem.id})!
                    
                    modelData.checkLists[indexList].items[index] = draftItem
                }
                
                // Notification
                if draftItem.haveDueDate {
                    ///sending notification
                    AppNotification().schedule(item: draftItem)
                }else {
                    ///removing notification
                    AppNotification().remove(ID: draftItem.id)
                }
                
                /// Stay in the ItemList View
                modelData.listSelector = modelData.checkLists[indexList].id
                
            }label: {
                Text("Done")
            }
        }
        .foregroundColor(modelData.checkLists[indexList].color)
    }
}

struct ItemToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ItemToolBar(draftItem: .constant(ModelData().checkLists[0].items[0]), showInfo: .constant(true), indexList: 0)
            .environmentObject(ModelData())
    }
}
