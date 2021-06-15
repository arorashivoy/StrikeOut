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
	@Binding var item: CheckList.Items
	
	var checkList: CheckList
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 20) {
			
			HStack {
				Spacer()
				Button("Done"){
					showInfo = false
//					TODO: Change id to take unused id
					if item.id == UUID(uuidString: "00000000-0000-0000-0000-000000000000") && item.itemName.trimmingCharacters(in: [" "]) != "" {
						let index: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
						
						item.id = UUID()
						
						modelData.checkLists[index].items.append(item)
					}
//					item = CheckList.Items.default
					
				}
			}
			List{
				HStack{
					Text("Name")
						.font(.headline)
						.bold()
					Divider()
						.brightness(0.40)
					TextField("Item Name", text: $item.itemName)
						.font(.subheadline)
				}
				if checkList.showQuantity {
					HStack {
						Stepper("Quantity: \(item.itemQuantity!)", onIncrement: {
							item.itemQuantity! += 1
						},onDecrement: {
							item.itemQuantity! -= 1
						})
					}
				}
				
				Toggle(isOn: $item.isCompleted, label: {
					Text("Completed")
				})
				
				ZStack(alignment: .topLeading) {
					TextEditor(text: $item.note)
						.font(.body)
						.foregroundColor(.gray)
					if item.note.trimmingCharacters(in: [" "]) == ""{
						Text("Notes")
							.font(.body)
							.foregroundColor(.secondary)
							.padding([.top, .leading], 5.0)
					}
				}
			}
		}
		.padding()
	}
}

struct ItemInfo_Previews: PreviewProvider {
	static var previews: some View {
		ItemInfo(showInfo: .constant(true), item: .constant(ModelData().checkLists[0].items[1]), checkList: ModelData().checkLists[0] )
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
