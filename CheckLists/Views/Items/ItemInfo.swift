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
    
    @Binding var editItem: CheckList.Items
    
	var ID: CheckList.Items.ID
	
	var checkList: CheckList
	
	var body: some View {
		
		let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		
		VStack(alignment: .center, spacing: 20) {
			
///         To display cancel(only when the new item is created) and done button
            ItemToolBar(editItem: $editItem, showInfo: $showInfo, indexList: indexList)
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
                    TextField("Item Name", text: $editItem.itemName)
						.font(.subheadline)
                        .foregroundColor(.primary)
				}
                
///             Quantity stepper only when showQuantity is enabled for checklist
				if checkList.showQuantity {
					HStack {
						Stepper("Quantity: \(editItem.itemQuantity)", onIncrement: {
							editItem.itemQuantity += 1
						},onDecrement: {
							editItem.itemQuantity -= 1
						})
					}
				}
				
///             Complete toggle
				Toggle(isOn: $editItem.isCompleted, label: {
					Text("Completed")
				})
                .onChange(of: editItem.isCompleted) { val in
                    if val {
                        AppNotification().remove(ID: editItem.id)
                    }
                }
                
///             Date and time
                DateSelection(dueDate: editItem.dueDate ?? Date(),
                              dueTime: editItem.dueDate ?? Date(), editItem: $editItem, indexList: indexList)
                    .environmentObject(modelData)
                
///             Notes text editor
                ItemNote(editItem: $editItem)
                    .environmentObject(modelData)
			}
			.listStyle(DefaultListStyle())
			
            
///         Delete button
			DeleteItem(showInfo: $showInfo, ID: ID, indexList: indexList)
                .environmentObject(modelData)
            
		}
        .foregroundColor(modelData.checkLists[indexList].color)
		.padding()
		
	}
}

struct ItemInfo_Previews: PreviewProvider {
	static var previews: some View {
        ItemInfo(showInfo: .constant(true), editItem: .constant(ModelData().checkLists[0].items[0]), ID: ModelData().checkLists[0].items[0].id, checkList: ModelData().checkLists[0])
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
