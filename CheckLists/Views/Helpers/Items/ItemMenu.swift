//
//  ItemMenu.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import SwiftUI

struct ItemMenu: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showListInfo: Bool
    
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
        Menu{
            ///show Completed button
            Button{
                modelData.checkLists[indexList].showCompleted.toggle()
                
            } label: {
                if modelData.checkLists[indexList].showCompleted {
                    Label("Hide Completed", systemImage: "eye.slash")
                } else {
                    Label("Show Completed", systemImage: "eye")
                }
            }
            
            ///sort Completed
            if modelData.checkLists[indexList].showCompleted {
                Button{
                    modelData.checkLists[indexList].completedAtBottom.toggle()
                    
                } label: {
                    Label("Sort Completed", systemImage: "arrow.up.arrow.down")
                }
            }
            
            /// Pin list
            Button{
                modelData.checkLists[indexList].isPinned.toggle()
            }label: {
                if modelData.checkLists[indexList].isPinned {
                    Label("UnPin List", systemImage: "pin.slash.fill")
                }else {
                    Label("Pin List", systemImage: "pin.fill")
                }
            }
            
            /// ListInfo
            Button{
                showListInfo.toggle()
                
            }label: {
                Label("Edit List", systemImage: "pencil")
            }
            
            /// Delete Button
            Button{
                modelData.listSelector = nil
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20){
                    /// To remove notification of all the items in the list
                    for item in modelData.checkLists[indexList].items {
                        AppNotification().remove(ID: item.id)
                    }
                    
                    modelData.checkLists.remove(at: indexList)
                }
                
            }label: {
                Label("Delete List", systemImage: "trash")
                    .foregroundColor(.red)
            }
            
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .font(.title3)
                .foregroundColor(modelData.checkLists[indexList].color)
        }
        }
    }
}

struct ItemMenu_Previews: PreviewProvider {
    static var previews: some View {
        ItemMenu(showListInfo: .constant(false), indexList: 0)
            .environmentObject(ModelData())
    }
}
