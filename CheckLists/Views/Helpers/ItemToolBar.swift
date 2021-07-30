//
//  ItemToolBar.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ItemToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showInfo: Bool
    
    var newItem: Bool
    var indexList: Int
    var index: Int
    var ID: CheckList.Items.ID
    
    var body: some View {
        HStack {
            if newItem {
                Button{
                    showInfo = false
                    modelData.checkLists[indexList].items[index].id = CheckList.Items.default.id
                    
                }label:{
                    Text("Cancel")
                }
            }
            Spacer()
            Button{
                showInfo = false
                
                if (ID == CheckList.Items.default.id && modelData.checkLists[indexList].items[index].itemName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                    
                    modelData.checkLists[indexList].items[index].id = UUID()
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
        ItemToolBar(showInfo: .constant(true), newItem: true, indexList: 0, index: 0, ID: ModelData().checkLists[0].items[0].id)
            .environmentObject(ModelData())
    }
}
