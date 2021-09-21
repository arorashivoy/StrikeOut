//
//  ListDisplay.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 17/09/21.
//

import SwiftUI

struct ListDisplay: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var draftList: CheckList
    @Binding var editSheet: Bool
    
    var checkLists: [CheckList]
    var body: some View {
        
        /// For iOS 15
        if #available(iOS 15.0, *) {
            /// Showing Lists
            ForEach(checkLists){ checkList in
                NavigationLink(
                    destination: ItemList(checkList: checkList).environmentObject(modelData),
                    tag: checkList.id,
                    selection: $modelData.listSelector
                ){
                    ListRow(checkList: checkList)
                        .environmentObject(modelData)
                }
                /// leading swipe buttons
                .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                    Button{
                        if let indexList = modelData.checkLists.firstIndex(where: {$0.id == checkList.id }){
                            modelData.checkLists[indexList].isPinned.toggle()
                        }
                    }label: {
                        if checkList.isPinned{
                            Image(systemName: "pin.slash.fill")
                        }else{
                            Image(systemName: "pin.fill")
                        }
                    }
                    .tint(checkList.color)
                })
                /// trailing swipe buttons
                .swipeActions {
                    /// Delete Button
                    Button(role: .destructive){
                        if let index: Int = checkLists.firstIndex(where: { $0.id == checkList.id }) {
                            removeRow(checkLists, at: IndexSet(integer: index))
                        }
                        
                    }label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(.red)
                    
                    /// Info Button
                    Button{
                        editSheet.toggle()
                        draftList = checkList
                    }label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .tint(.gray)
                }
            }
        }
    }
    
    /// remove row with .onDelete method
    /// - Parameters:
    ///   - list: list used in ForEach
    ///   - offset: indexSet of the above list
    func removeRow(_ list: [CheckList], at offset: IndexSet) {
        for i in offset {
            if let indexList = modelData.checkLists.firstIndex(where: {$0.id == list[i].id}) {
            
                /// removing Notifications
                for item in modelData.checkLists[indexList].items {
                    AppNotification().remove(list: modelData.checkLists[i], itemID: item.id)
                }
                
                modelData.checkLists.remove(at: indexList)
            }
        }
    }

}

struct ListDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ListDisplay(draftList: .constant(CheckList.default), editSheet: .constant(false), checkLists: [CheckList.data])
    }
}
