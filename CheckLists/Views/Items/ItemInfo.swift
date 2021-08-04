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
    @Binding var draftItem: CheckList.Items
	
	var checkList: CheckList
	
	var body: some View {
		
		let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		
		VStack(alignment: .center, spacing: 20) {
			
///         To display cancel(only when the new item is created) and done button
            ItemToolBar(draftItem: $draftItem, showInfo: $showInfo, indexList: indexList)
                .environmentObject(modelData)
            
///         Item editing options
			List{
                
///             Item name
				HStack{
					Text("Name")
						.font(.headline)
						.bold()
					Divider()
						.brightness(0.40)
                    TextField("Item Name", text: $draftItem.itemName)
						.font(.subheadline)
                        .foregroundColor(.primary)
				}
                
///             Quantity stepper only when showQuantity is enabled for checklist
				if checkList.showQuantity {
					HStack {
						Stepper("Quantity: \(draftItem.itemQuantity)", onIncrement: {
							draftItem.itemQuantity += 1
						},onDecrement: {
							draftItem.itemQuantity -= 1
						})
					}
				}
				
///             Complete toggle
				Toggle(isOn: $draftItem.isCompleted, label: {
					Text("Completed")
				})
                .onChange(of: draftItem.isCompleted) { val in
                    if val {
                        AppNotification().remove(ID: draftItem.id)
                    }
                }
                
///             Date and time
                DateSelection(dueDate: draftItem.dueDate ?? Date(),
                              dueTime: draftItem.dueDate ?? Date(), editItem: $draftItem, indexList: indexList)
                    .environmentObject(modelData)
                
///             Notes text editor
                ItemNote(editItem: $draftItem)
                    .environmentObject(modelData)
			}
			.listStyle(DefaultListStyle())
			
            
///         Delete button
            DeleteItem(showInfo: $showInfo, ID: draftItem.id, indexList: indexList)
                .environmentObject(modelData)
            
		}
        .foregroundColor(modelData.checkLists[indexList].color)
		.padding()
		
	}
}

struct ItemInfo_Previews: PreviewProvider {
	static var previews: some View {
        ItemInfo(showInfo: .constant(true), draftItem: .constant(ModelData().checkLists[0].items[0]), checkList: ModelData().checkLists[0])
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
