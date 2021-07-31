//
//  ItemToolBar.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ItemToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var editItem: CheckList.Items
    @Binding var showInfo: Bool
    
    var indexList: Int
    
    var body: some View {
        HStack {
            
            ///Cancel Button
            Button{
                showInfo = false
                editItem = CheckList.Items.default
                
            }label:{
                Text("Cancel")
            }

            Spacer()
            
            ///Done button
            Button{
                showInfo = false
                
                if (editItem.id == CheckList.Items.default.id && editItem.itemName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                    
                    editItem.id = UUID()
                    ///adding new Item to the list
                    modelData.checkLists[indexList].items.append(editItem)
                    
                }else {
                    ///Changing the data of item if it already existed
                    let index: Int = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == editItem.id})!
                    
                    modelData.checkLists[indexList].items[index] = editItem
                }
                
                // Notification
                if editItem.haveDueDate {
                    ///sending notification
                    AppNotification().schedule(item: editItem)
                }else {
                    ///removing notification
                    AppNotification().remove(ID: editItem.id)
                }
                
            }label: {
                Text("Done")
            }
        }
        .foregroundColor(modelData.checkLists[indexList].color)
    }
}

struct ItemToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ItemToolBar(editItem: .constant(ModelData().checkLists[0].items[0]), showInfo: .constant(true), indexList: 0)
            .environmentObject(ModelData())
    }
}
