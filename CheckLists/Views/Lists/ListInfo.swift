//
//  ListInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 17/06/21.
//

import SwiftUI

struct ListInfo: View {
	@EnvironmentObject var modelData: ModelData
	@Binding var addSheet: Bool
    @State private var ImagePicker: Bool = false
	var listEdit: Binding<EditMode>?
	
    var ID: CheckList.ID
    
	var body: some View {
///		finding index
        let index: Int = modelData.checkLists.firstIndex(where: {$0.id == ID}) ?? 0
        
		VStack(alignment: .center) {
            
///         cancel and done button for new list view
            ListToolBar(addSheet: $addSheet, index: index, ID: ID)
            
///         List editing options
			List{
///				Text field for list name
				HStack{
					Text("Name")
						.bold()
						.font(.headline)
					Divider()
						.brightness(0.4)
					TextField("List Name", text: $modelData.checkLists[index].listName)
						.font(.subheadline)
                        .foregroundColor(.primary)
				}
                
///             To pin the list
                Toggle(isOn: $modelData.checkLists[index].isPinned, label: {
                    Text("Pin")
                })
                
///             show quantity for lists
				Toggle(isOn: $modelData.checkLists[index].showQuantity, label: {
					Text("Show Quantity")
						.bold()
				})
                
///             Default time picker
                DatePicker("Select default Time",
                           selection: $modelData.checkLists[index].defaultTime,
                           displayedComponents: .hourAndMinute)
                
///             Picking color for lists
                ColorPicker("Select List Color", selection: $modelData.checkLists[index].color, supportsOpacity: false)
                
///             List thumbnail picking
                Section(header: Text("Choose Thumbnail Image")){
                    Picker("Choose the thumbnail image", selection: $modelData.checkLists[index].imageName){
                        ForEach(CheckList.Images.allCases){
                            Image(systemName: "\($0.rawValue)").tag($0)
                        }
                    }
                }

///             For description
                ZStack(alignment:.leading){
                    TextEditor(text: $modelData.checkLists[index].description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    if modelData.checkLists[index].description.trimmingCharacters(in: [" "]) == "" {
                        Text("Description")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.leading, 5)
                    }
                }
            }
            .listStyle(DefaultListStyle())
            Spacer()
            
///         Delete button
			if ID != CheckList.default.id {
				
				Button{
					listEdit?.animation().wrappedValue = .inactive
                    
                    ///To remove notification of all the items in the list
                    for item in modelData.checkLists[index].items {
                        AppNotification().remove(ID: item.id)
                    }
                    
                    modelData.listSelector = nil
					modelData.checkLists[index]=CheckList.default
					
				}label: {
					Text("Delete List")
						.font(.title3)
						.bold()
						.foregroundColor(.red)
						.padding()
				}
			}
			Spacer()
		}
        .foregroundColor(modelData.checkLists[index].color)
        .navigationTitle(modelData.checkLists[index].listName)
	}
}


struct ListInfo_Previews: PreviewProvider {
	static var previews: some View {
        ListInfo(addSheet: .constant(false), listEdit: .constant(EditMode.inactive), ID: ModelData().checkLists[0].id)
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}

