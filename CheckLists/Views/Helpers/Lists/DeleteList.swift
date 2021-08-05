//
//  DeleteList.swift
//  CheckLists
//
//  Created by Shivoy Arora on 04/08/21.
//

import SwiftUI

struct DeleteList: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showInfo: Bool
    
    var ID: CheckList.ID
    
    var body: some View {
        if ID != CheckList.default.id {
            
            Button{
                showInfo = false
                
                let indexList: Int = modelData.checkLists.firstIndex(where: { $0.id == ID })!
                
                /// To remove notification of all the items in the list
                for item in modelData.checkLists[indexList].items {
                    AppNotification().remove(ID: item.id)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                    modelData.checkLists.remove(at: indexList)
                }
            }label: {
                Text("Delete List")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

struct DeleteList_Previews: PreviewProvider {
    static var previews: some View {
        DeleteList(showInfo: .constant(true), ID: ModelData().checkLists[0].id)
    }
}
