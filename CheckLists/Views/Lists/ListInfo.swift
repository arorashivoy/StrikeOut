//
//  ListInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 17/06/21.
//

import SwiftUI

struct ListInfo: View {
    @EnvironmentObject var modelData: ModelData
    @State private var imagePicker: Bool = false
    @Binding var showInfo: Bool
    @Binding var draftList: CheckList
    
    var body: some View {
        ZStack{
            VStack(alignment: .center) {
                
                /// cancel and done button for new list view
                ListToolBar(showInfo: $showInfo, draftList: $draftList)
                    .environmentObject(modelData)
                
                /// List editing options
                List{
                    
                    Section{
                        ///	Text field for list name
                        HStack{
                            Text("Name")
                                .bold()
                                .font(.headline)
                            Divider()
                                .brightness(0.4)
                            TextField("List Name", text: $draftList.listName)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        
                        /// To pin the list
                        Toggle(isOn: $draftList.isPinned, label: {
                            Text("Pin")
                        })
                        
                        /// show quantity for lists
                        Toggle(isOn: $draftList.showQuantity, label: {
                            Text("Show Quantity")
                                .bold()
                        })
                    }
                    
                    Section(){
                        /// Default time picker
                        DatePicker("Select default Time",
                                   selection: $draftList.defaultTime,
                                   displayedComponents: .hourAndMinute)
                        
                        /// Picking color for lists
                        ColorPicker("Select List Color", selection: $draftList.color, supportsOpacity: false)
                        
                        /// List thumbnail picking
                        Button{
                            withAnimation {
                                imagePicker.toggle()
                            }
                        }label: {
                            Label("Thumbnail", systemImage: draftList.imageName)
                        }
                    }
                    /// For description
                    ListDescription(draftList: $draftList)
                    
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.bottom, 0)
                Spacer()
                
                /// Delete button
                DeleteList(showInfo: $showInfo, ID: draftList.id)
                    .environmentObject(modelData)
                
            }
            .foregroundColor(draftList.color)
            .navigationTitle(draftList.listName)
            
            /// Image Picker overlay
            if imagePicker {
                /// To make the background gray
                Color.gray.opacity(0.4).ignoresSafeArea()
                
                ImagePicker(draftList: $draftList, imagePicker: $imagePicker)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}


struct ListInfo_Previews: PreviewProvider {
    static var previews: some View {
        ListInfo(showInfo: .constant(true), draftList: .constant(ModelData().checkLists[0]))
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}

