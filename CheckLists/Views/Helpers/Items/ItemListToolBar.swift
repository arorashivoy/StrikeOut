//
//  ItemMenu.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import SwiftUI

struct ItemListToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.defaultCompleted.rawValue) var defaultCompleted = false
    @Binding var showListInfo: Bool
    
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
            HStack {
                /// ListInfo
                Button{
                    withAnimation(.easeInOut(duration: 2)) {
                        showListInfo.toggle()
                    }
                    
                }label: {
                    Label("Edit List", systemImage: "pencil")
                        .foregroundColor(modelData.checkLists[indexList].color)
                        .padding(.trailing, 3)
                }
                
                /// Menu
                Menu{
                    /// show Completed button
                    Button{
                        if modelData.checkLists[indexList].showCompleted == true {
                            modelData.checkLists[indexList].showCompleted = false
                        }else if modelData.checkLists[indexList].showCompleted == false {
                            modelData.checkLists[indexList].showCompleted = true
                        }else {
                            modelData.checkLists[indexList].showCompleted = !defaultCompleted
                        }
                        
                    } label: {
                        if (modelData.checkLists[indexList].showCompleted ?? defaultCompleted) {
                            Label("Hide Completed", systemImage: "eye.slash")
                        } else {
                            Label("Show Completed", systemImage: "eye")
                        }
                    }
                    
                    ///sort Completed
                    if (modelData.checkLists[indexList].showCompleted ?? defaultCompleted) {
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
                            Label("Unpin List", systemImage: "pin.slash.fill")
                        }else {
                            Label("Pin List", systemImage: "pin.fill")
                        }
                    }
                    
                    /// Delete Button
                    Button{
                        withAnimation {
                            modelData.listSelector = nil
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20){
                            /// To remove notification of all the items in the list
                            for item in modelData.checkLists[indexList].items {
                                AppNotification().remove(list: modelData.checkLists[indexList], itemID: item.id)
                            }
                            
                            modelData.checkLists.remove(at: indexList)
                        }
                        
                    }label: {
                        Label("Delete List", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    
                } label: {
                    withAnimation(.easeInOut(duration: 2)){
                        Label("Menu", systemImage: "ellipsis.circle")
                            .foregroundColor(modelData.checkLists[indexList].color)
                    }
                }
            }
        }
    }
}

struct ItemListToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ItemListToolBar(showListInfo: .constant(false), indexList: 0)
            .environmentObject(ModelData())
    }
}
