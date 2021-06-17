//
//  ListInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 17/06/21.
//

import SwiftUI

struct ListInfo: View {
	@EnvironmentObject var modalData: ModelData
	
	var checkList: CheckList
	
	var body: some View {
		let index = modalData.checkLists.firstIndex(where: {$0.id == checkList.id}) ?? 0
		
		List{
			
			HStack{
				Text("Name")
					.bold()
					.font(.headline)
				Divider()
					.brightness(0.4)
				TextField("List Name", text: $modalData.checkLists[index].listName)
					.font(.subheadline)
			}
			Toggle(isOn: $modalData.checkLists[index].showQuantity, label: {
				Text("Show Quantity")
					.bold()
			})
			ZStack(alignment:.leading){
				TextEditor(text: $modalData.checkLists[index].description)
					.font(.body)
					.foregroundColor(.gray)
				if modalData.checkLists[index].description.trimmingCharacters(in: [" "]) == "" {
					Text("Description")
						.font(.body)
						.foregroundColor(.secondary)
						.padding(.leading, 5)
				}
			}
		}
	}
}

struct ListInfo_Previews: PreviewProvider {
	static var previews: some View {
		ListInfo(checkList: ModelData().checkLists[1])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}
