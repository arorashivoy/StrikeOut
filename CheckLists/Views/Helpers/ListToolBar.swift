//
//  ListToolBar.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ListToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var addSheet: Bool
    
    var index: Int
    var ID: CheckList.ID
    
    var body: some View {
        HStack{
            if ID == CheckList.default.id {
                Button{
                    addSheet = false
                }label: {
                    Text("Cancel")
                        .padding()
                        .foregroundColor(.accentColor)
                }
                Spacer()
                Button{
                    if modelData.checkLists[index].listName.trimmingCharacters(in: CharacterSet.whitespaces) != "" {
                        modelData.checkLists[index].id = UUID()
                    }
                    addSheet = false
                }label: {
                    Text("Done")
                        .padding()
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct ListToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ListToolBar(addSheet: .constant(false), index: 0, ID: CheckList.default.id)
    }
}
