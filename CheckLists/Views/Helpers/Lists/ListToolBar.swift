//
//  ListToolBar.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ListToolBar: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showInfo: Bool
    @Binding var draftList: CheckList
    
    var body: some View {
        HStack{
            
            ///Cancel Button
            Button{
                withAnimation(.spring(dampingFraction: 0.25, blendDuration: 2)) {
                    showInfo = false
                }
                draftList = CheckList.default
            }label: {
                Text("Cancel")
                    .padding()
            }
            Spacer()
            
            /// Done Button
            Button{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                    withAnimation(.spring(dampingFraction: 0.25, blendDuration: 2)) {
                        showInfo = false
                    }
                }
                
                if (draftList.id == CheckList.default.id && draftList.listName.trimmingCharacters(in: CharacterSet.whitespaces) != "") {
                    
                    draftList.id = UUID()
                    
                    ///Adding new List
                    modelData.checkLists.append(draftList)
                }else if draftList.id != CheckList.default.id {
                    
                    /// Rescheduling notification when default time is changed
                    for index in (0 ..< draftList.items.count) {
                        if draftList.items[index].haveDueDate && !draftList.items[index].haveDueTime {
                            
                            /// Changing dueDate
                            draftList.items[index].dueDate = setDateTime(date: draftList.items[index].dueDate!, time: draftList.defaultTime)
                            
                            /// Rescheduling
                            AppNotification().schedule(list: draftList, item: draftList.items[index])
                        }
                    }

                    
                    ///Changing the data of list if already exist
                    let indexList: Int = modelData.checkLists.firstIndex(where: { $0.id == draftList.id })!
                    
                    modelData.checkLists[indexList] = draftList
                    
                }
                
            }label: {
                Text("Done")
                    .padding()
            }
        }
        .foregroundColor(draftList.color)
    }
}

struct ListToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ListToolBar(showInfo: .constant(true), draftList: .constant(CheckList.data))
            .environmentObject(ModelData())
    }
}
