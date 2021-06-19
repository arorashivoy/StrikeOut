//
//  ItemInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemInfo: View {
	@EnvironmentObject var modelData: ModelData
	@Binding var showInfo: Bool
	var ID: CheckList.Items.ID
	
	var checkList: CheckList
	
	var body: some View {
		
		let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		let index: Int = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == ID}) ?? 0
		
		VStack(alignment: .leading, spacing: 20) {
			
			HStack {
				if ID == CheckList.Items.default.id {
					Button("Cancel"){
						showInfo = false
					}
				}
				Spacer()
				Button("Done"){
					showInfo = false
					
					if (ID == CheckList.Items.default.id && modelData.checkLists[indexList].items[index].itemName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
						
						modelData.checkLists[indexList].items[index].id = UUID()
					}
					
				}
			}
			List{
				HStack{
					Text("Name")
						.font(.headline)
						.bold()
					Divider()
						.brightness(0.40)
					TextField("Item Name", text: $modelData.checkLists[indexList].items[index].itemName)
						.font(.subheadline)
				}
				if checkList.showQuantity {
					HStack {
						Stepper("Quantity: \(modelData.checkLists[indexList].items[index].itemQuantity!)", onIncrement: {
							modelData.checkLists[indexList].items[index].itemQuantity! += 1
						},onDecrement: {
							modelData.checkLists[indexList].items[index].itemQuantity! -= 1
						})
					}
				}
				
				Toggle(isOn: $modelData.checkLists[indexList].items[index].isCompleted, label: {
					Text("Completed")
				})
				
				ZStack(alignment: .topLeading) {
					TextEditor(text: $modelData.checkLists[indexList].items[index].note)
						.font(.body)
						.foregroundColor(.gray)
					if modelData.checkLists[indexList].items[index].note.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""{
						Text("Notes")
							.font(.body)
							.foregroundColor(.secondary)
							.padding([.top, .leading], 5.0)
					}
				}
				
				if modelData.checkLists[indexList].items[index].id != CheckList.Items.default.id {
					
					Button{
						showInfo = false
						modelData.checkLists[indexList].items[index] = CheckList.Items.default
						
					} label: {
						Text("Delete Record")
							.font(.title3)
							.bold()
							.frame(alignment: .center)
							.foregroundColor(.red)
						
					}
					.frame(width: 300, alignment: .center)
				}
			}
		}
		.padding()
		
	}
}

struct ItemInfo_Previews: PreviewProvider {
	static var previews: some View {
		ItemInfo(showInfo: .constant(true), ID: ModelData().checkLists[0].items[1].id, checkList: ModelData().checkLists[0] )
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
