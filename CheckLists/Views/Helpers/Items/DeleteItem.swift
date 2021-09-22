//
//  DeleteItem.swift
//  CheckLists
//
//  Created by Shivoy Arora on 31/07/21.
//

import SwiftUI

struct DeleteItem: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showInfo: Bool
    
    var ID: CheckList.Items.ID
    var indexList: Int
    
    var body: some View {
        if ID != CheckList.Items.default.id {
            
            Button{
                showInfo = false
                AppNotification().remove(list: modelData.checkLists[indexList], itemID: ID)
                
                if let index = modelData.checkLists[indexList].items.firstIndex(where: { $0.id == ID }) {
                    modelData.checkLists[indexList].items.remove(at: index)
                }
                
            } label: {
                Text("Delete Record")
                    .font(.title3)
                    .bold()
                    .frame(alignment: .center)
                    .foregroundColor(.red)
                    .padding()
                
            }
        }
    }
}

struct DeleteItem_Previews: PreviewProvider {
    static var previews: some View {
        DeleteItem(showInfo: .constant(true), ID: CheckList.data.items[0].id, indexList: 0)
    }
}
