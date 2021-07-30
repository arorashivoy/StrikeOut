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
        Menu{
            ///show Completed button
            Button{
                modelData.checkLists[indexList].showCompleted.toggle()
            } label: {
                if modelData.checkLists[indexList].showCompleted {
                    Text("Hide Completed")
                } else {
                    Text("Show Completed")
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
            
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .font(.title3)
        }
    }
}

struct ItemMenu_Previews: PreviewProvider {
    static var previews: some View {
        ItemMenu(indexList: 0)
            .environmentObject(ModelData())
    }
}
