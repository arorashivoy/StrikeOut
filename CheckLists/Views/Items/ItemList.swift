//
//  ItemList.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemList: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.colorSchemes.rawValue) var colorSchemes: AppColorScheme = AppColorScheme.system
    @AppStorage(StorageString.defaultCompleted.rawValue) var defaultCompleted = false
    @State private var showInfo: Bool = false
    @State private var newItem: Bool = false
    @State private var draftItem: CheckList.Items = CheckList.Items.default
    @State private var showListInfo: Bool = false
    @State private var draftList: CheckList = CheckList.default
    @State private var deniedAlert: Bool = false
    
    var checkList: CheckList
    
    var body: some View {
        
        if let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id}) {
            
            let sortedItems = sortItems(checkList: modelData.checkLists[indexList])
            
            List(){
                ForEach(sortedItems) { item in
                    ItemRow(draftItem: $draftItem, deniedAlert: $deniedAlert, item: item, indexList: indexList)
                        .environmentObject(modelData)
                }
                
                /// Drag to delete
                .onDelete{ indexSet in
                    removeRow(sortedItems, indexList: indexList, at: indexSet)
                }
                
                /// new item button
                AddInfoButton(showInfo: $newItem, draftItem: $draftItem, checkList: checkList, item: CheckList.Items.default)
                    .sheet(isPresented: $newItem) {
                        ItemInfo(showInfo: $newItem, draftItem: $draftItem, deniedAlert: $deniedAlert, indexList: indexList)
                            .environmentObject(modelData)
                            .preferredColorScheme(setColorScheme())
                        
                    }
                    /// To show alert if noti is denied
                    .alert(isPresented: $deniedAlert) {
                        Alert(title: Text("Enable Notifications"),
                              message: Text("To never forget anything"),
                              primaryButton: .default( Text("Go to Settings"), action: openSetting),
                              secondaryButton: .destructive(Text("Cancel")))
                    }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(checkList.listName)
            .foregroundColor(modelData.checkLists[indexList].color)
            .toolbar{
                /// Toolbar
                ItemListToolBar(showListInfo: $showListInfo, indexList: indexList)
                    .environmentObject(modelData)
            }
            
            /// List info sheet
            .sheet(isPresented: $showListInfo, content: {
                ListInfo(showInfo: $showListInfo, draftList: $draftList)
                    .environmentObject(modelData)
                    .preferredColorScheme(setColorScheme())
                    .onAppear(perform: {
                        draftList = modelData.checkLists[indexList]
                    })
            })
        }
    }
    
    /// To set color scheme which the user chooses
    /// - Returns: colorScheme
    func setColorScheme() -> ColorScheme? {
        switch colorSchemes {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
    
    /// to remove item using .onDelete method
    /// - Parameters:
    ///   - list: list used in ForEach
    ///   - indexList: index of the CheckList
    ///   - offset: indexSet of the above list
    func removeRow(_ list: [CheckList.Items], indexList: Int, at offset: IndexSet) {
        for i in offset {
            if let index = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == list[i].id}) {
                
                /// removing Notification
                AppNotification().remove(list: checkList, itemID: modelData.checkLists[indexList].items[index].id)
                
                modelData.checkLists[indexList].items.remove(at: index)
            }
        }
    }
    
    /// sort items to show completed at bottom (if asked) and flagged at top
    /// - Parameter checkList: The list whose items are to be sort
    /// - Returns: the sorted items list
    func sortItems(checkList: CheckList) -> [CheckList.Items] {
        if checkList.showCompleted  ?? defaultCompleted {
            let completedList = checkList.items.filter{ (!$0.isCompleted || !checkList.completedAtBottom) && $0.flagged} + checkList.items.filter{ (!$0.isCompleted || !checkList.completedAtBottom) && !$0.flagged }
            let incompleteList = checkList.items.filter{ ($0.isCompleted && checkList.completedAtBottom) && $0.flagged } + checkList.items.filter{ ($0.isCompleted && checkList.completedAtBottom) && !$0.flagged}
            return  completedList + incompleteList
        }else {
            return checkList.items.filter{ !$0.isCompleted && $0.flagged} + checkList.items.filter{ !$0.isCompleted && !$0.flagged}
        }
    }
}

/// To open setting in the alert if notification was denied
func openSetting() {
    if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
        if UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList(checkList: ModelData().checkLists[0])
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
