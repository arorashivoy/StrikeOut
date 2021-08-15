//
//  ListInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 17/06/21.
//

import SwiftUI

struct ListInfo: View {
	@EnvironmentObject var modelData: ModelData
    @State private var ImagePicker: Bool = false
    @Binding var showInfo: Bool
    @Binding var draftList: CheckList
    
	var body: some View {
		VStack(alignment: .center) {
            
///         cancel and done button for new list view
            ListToolBar(showInfo: $showInfo, draftList: $draftList)
                .environmentObject(modelData)
            
///         List editing options
			List{
                
///				Text field for list name
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
                
///             To pin the list
                Toggle(isOn: $draftList.isPinned, label: {
                    Text("Pin")
                })
                
///             show quantity for lists
				Toggle(isOn: $draftList.showQuantity, label: {
					Text("Show Quantity")
						.bold()
				})
                
///             Default time picker
                DatePicker("Select default Time",
                           selection: $draftList.defaultTime,
                           displayedComponents: .hourAndMinute)
                
///             Picking color for lists
                ColorPicker("Select List Color", selection: $draftList.color, supportsOpacity: false)
                
///             List thumbnail picking
                Section(header: Text("Choose Thumbnail Image")){
                    Picker("Choose the thumbnail image", selection: $draftList.imageName){
                        ForEach(CheckList.Images.allCases){
                            Image(systemName: "\($0.rawValue)").tag($0)
                        }
                    }
                }
            }
            .listStyle(DefaultListStyle())
            .frame(height: 480)
            .padding(.bottom, 0)
            
            /// For description
            ListDescription(draftList: $draftList)
                .padding(.top, 0)
            
            Spacer()
            
///         Delete button
            DeleteList(showInfo: $showInfo, ID: draftList.id)
                .environmentObject(modelData)
            
			Spacer()
		}
        .foregroundColor(draftList.color)
        .navigationTitle(draftList.listName)
	}
}


struct ListInfo_Previews: PreviewProvider {
	static var previews: some View {
        ListInfo(showInfo: .constant(true), draftList: .constant(ModelData().checkLists[0]))
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}

