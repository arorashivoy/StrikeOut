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
	
	var checkList: CheckList
    
	var body: some View {
///		finding index
		let index: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id}) ?? 0
        
		VStack(alignment: .center) {
            
///         cancel and done button for new list view
			HStack{
				if checkList.id == CheckList.default.id {
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
                
///             show quantity for lists
				Toggle(isOn: $modelData.checkLists[index].showQuantity, label: {
					Text("Show Quantity")
						.bold()
				})
                
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
            Spacer()
            
///         Delete button
			if checkList.id != CheckList.default.id {
				
				Button{
					modelData.listSelector = nil
					listEdit?.animation().wrappedValue = .inactive
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
        ListInfo(addSheet: .constant(false), listEdit: .constant(EditMode.active), checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}

