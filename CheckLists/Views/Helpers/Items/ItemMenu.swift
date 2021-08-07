//
//  ItemMenu.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import SwiftUI

struct ItemMenu: View {
    @EnvironmentObject var modelData: ModelData
    
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
            
            Button{
                modelData.checkLists.remove(at: indexList)
            }label: {
                Label("Delete", systemImage: "trash")
                    .foregroundColor(.red)
            }
            
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .font(.title3)
        }
        }
    }
}

struct ItemMenu_Previews: PreviewProvider {
    static var previews: some View {
        ItemMenu(indexList: 0)
            .environmentObject(ModelData())
    }
}
