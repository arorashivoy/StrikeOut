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
	
	var checkList: CheckList
	
	var body: some View {
		
		let index: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id}) ?? 0
		
		VStack(alignment: .center) {
			HStack{
				if checkList.id == CheckList.default.id {
					Button{
						addSheet = false
					}label: {
						Text("Cancel")
							.padding()
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
					}
				}
			}
			
			List{
				
				HStack{
					Text("Name")
						.bold()
						.font(.headline)
					Divider()
						.brightness(0.4)
					TextField("List Name", text: $modelData.checkLists[index].listName)
						.font(.subheadline)
				}
				Toggle(isOn: $modelData.checkLists[index].showQuantity, label: {
					Text("Show Quantity")
						.bold()
				})
				ZStack(alignment:.leading){
					TextEditor(text: $modelData.checkLists[index].description)
						.font(.body)
						.foregroundColor(.gray)
					if modelData.checkLists[index].description.trimmingCharacters(in: [" "]) == "" {
						Text("Description")
							.font(.body)
							.foregroundColor(.secondary)
							.padding(.leading, 5)
					}
				}
			}
			if checkList.id != CheckList.default.id {
				
				Button{
					modelData.listSelector = nil
					modelData.checkLists[index].listName=CheckList.default.listName
					
				}label: {
					Text("Delete List")
						.font(.title3)
						.bold()
						.foregroundColor(.red)
				}
			}
			Spacer()
			
			
		}
		
	}
}


struct ListInfo_Previews: PreviewProvider {
	static var previews: some View {
		ListInfo(addSheet: .constant(false), checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}

