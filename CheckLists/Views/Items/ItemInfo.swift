//
//  ItemInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemInfo: View {
	@Binding var showInfo: Bool
	@Binding var item: CheckList.Items
	var checkList: CheckList

    var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			
			HStack {
				Spacer()
				Button("Done"){
					showInfo = false
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
				
				TextEditor(text: $item.note)
					.font(.body)
					.foregroundColor(.secondary)
			}
		}
		.padding()
    }
}

struct ItemInfo_Previews: PreviewProvider {
    static var previews: some View {
		ItemInfo(showInfo: .constant(true), item: .constant(ModelData().checkLists[0].items[0]), checkList: ModelData().checkLists[0] )
			.preferredColorScheme(.dark)
    }
}
