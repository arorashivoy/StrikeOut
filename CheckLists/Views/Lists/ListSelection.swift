//
//  ListSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ListSelection: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var alarmModel: AlarmModel
    @AppStorage(StorageString.themeColor.rawValue) var themeColor = Color.blue
    @AppStorage(StorageString.colorSchemes.rawValue) var colorSchemes: AppColorScheme = AppColorScheme.system
    @State private var addSheet: Bool = false
    @State private var editSheet: Bool = false
    @State private var draftList: CheckList = CheckList.default
    @State private var settingsView: Bool = false
    
    var body: some View {
        
        let pinnedList = modelData.checkLists.filter{ $0.isPinned }
        let unpinnedList = modelData.checkLists.filter{ !$0.isPinned }
        
        NavigationView {
            Form{
                /// Showing all the available pinned List
                if pinnedList.count > 0 {
                    Section(header: Text("Pinned")) {
                        /// For iOS 15
                        if #available(iOS 15.0, *) {
                            /// Showing Lists
                            ListDisplay(draftList: $draftList, editSheet: $editSheet, checkLists: pinnedList)
                                .environmentObject(modelData)
                                .sheet(isPresented: $editSheet) {
                                    ListInfo(showInfo: $editSheet, draftList: $draftList)
                                        .environmentObject(modelData)
                                        .preferredColorScheme(setColorScheme(colorSchemes: colorSchemes))
                                }
                        }else {
                            /// Showing Lists
                            ForEach(pinnedList){ checkList in
                                NavigationLink(
                                    destination: ItemList(checkList: checkList).environmentObject(modelData),
                                    tag: checkList.id,
                                    selection: $modelData.listSelector
                                ){
                                    ListRow(checkList: checkList)
                                        .environmentObject(modelData)
                                }
                            }
                            .onDelete { indexSet in
                                removeRow(pinnedList, at: indexSet)
                            }
                        }
                    }
                }
                
                /// Showing all the available Unpinned List
                Section{
                    
                    /// For iOS 15
                    if #available(iOS 15.0, *) {
                        /// Showing Lists
                        ListDisplay(draftList: $draftList, editSheet: $editSheet, checkLists: unpinnedList)
                            .environmentObject(modelData)
                            .sheet(isPresented: $editSheet) {
                                ListInfo(showInfo: $editSheet, draftList: $draftList)
                                    .environmentObject(modelData)
                                    .preferredColorScheme(setColorScheme(colorSchemes: colorSchemes))
                            }
                    }else {
                        /// Showing Lists
                        ForEach(unpinnedList){ checkList in
                            NavigationLink(
                                destination: ItemList(checkList: checkList).environmentObject(modelData),
                                tag: checkList.id,
                                selection: $modelData.listSelector
                            ){
                                ListRow(checkList: checkList)
                                    .environmentObject(modelData)
                            }
                        }
                        .onDelete { indexSet in
                            removeRow(unpinnedList, at: indexSet)
                        }
                    }
                    
                    /// adding list button
                    Button{
                        withAnimation(.spring(dampingFraction: 0.25, blendDuration: 2)){
                            addSheet.toggle()
                        }
                        draftList = CheckList.default
                        
                    }label: {
                        Label("Add List", systemImage: "plus")
                            .font(.body)
                            .foregroundColor(.accentColor)
                    }
                    .scaleEffect(addSheet ? 1.5 : 1)
                    .sheet(isPresented: $addSheet, content: {
                        ListInfo(showInfo: $addSheet, draftList: $draftList)
                            .environmentObject(modelData)
                            .preferredColorScheme(setColorScheme(colorSchemes: colorSchemes))
                    })
                }
            }
            .navigationTitle("Lists")
            .toolbar {
                Button{
                    settingsView = true
                }label : {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.accentColor)
                }
            }
            /// Settings panel
            .fullScreenCover(isPresented: $settingsView, content: {
                SettingsView(checkLists: modelData.checkLists)
                    .environmentObject(alarmModel)
                    .accentColor(themeColor)
                    .preferredColorScheme(setColorScheme(colorSchemes: colorSchemes))
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
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

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection()
            .preferredColorScheme(.dark)
            .environmentObject(AlarmModel())
            .environmentObject(ModelData())
    }
}
