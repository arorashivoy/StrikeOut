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
    
    var newItem: Bool
    
	var ID: CheckList.Items.ID
	
	var checkList: CheckList
	
	var body: some View {
		
		let indexList: Int = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		let index: Int = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == ID}) ?? 0
		
		VStack(alignment: .center, spacing: 20) {
			
///         To display cancel(only when the new item is created) and done button
			ItemToolBar(showInfo: $showInfo, indexList: indexList, index: index, ID: ID)
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
					TextField("Item Name", text: $modelData.checkLists[indexList].items[index].itemName)
						.font(.subheadline)
                        .foregroundColor(.primary)
				}
                
///             Quantity stepper only when showQuantity is enabled for checklist
				if checkList.showQuantity {
					HStack {
						Stepper("Quantity: \(modelData.checkLists[indexList].items[index].itemQuantity)", onIncrement: {
							modelData.checkLists[indexList].items[index].itemQuantity += 1
						},onDecrement: {
							modelData.checkLists[indexList].items[index].itemQuantity -= 1
						})
					}
				}
				
///             Complete toggle
				Toggle(isOn: $modelData.checkLists[indexList].items[index].isCompleted, label: {
					Text("Completed")
				})
                .onChange(of: modelData.checkLists[indexList].items[index].isCompleted) { val in
                    if val {
                        AppNotification().remove(ID: modelData.checkLists[indexList].items[index].id)
                    }
                }
                
///             Date and time
                DateSelection(dueDate: modelData.checkLists[indexList].items[index].dueDate ?? Date(),
                              dueTime: modelData.checkLists[indexList].items[index].dueDate ?? Date(), indexList: indexList,
                              index: index)
                    .environmentObject(modelData)
                
///             Notes text editor
                ItemNote(indexList: indexList, index: index)
                    .environmentObject(modelData)
			}
			.listStyle(DefaultListStyle())
			
            
///         Delete button
			if modelData.checkLists[indexList].items[index].id != CheckList.Items.default.id {
				
				Button{
					showInfo = false
                    AppNotification().remove(ID: modelData.checkLists[indexList].items[index].id)
					modelData.checkLists[indexList].items[index] = CheckList.Items.default
					
				} label: {
					Text("Delete Record")
						.font(.title3)
						.bold()
						.frame(alignment: .center)
						.foregroundColor(.red)
						.padding()
					
				}
			}
		}
        .foregroundColor(modelData.checkLists[indexList].color)
		.padding()
		
	}
}

struct ItemInfo_Previews: PreviewProvider {
	static var previews: some View {
        ItemInfo(showInfo: .constant(true), newItem: true, ID: ModelData().checkLists[0].items[0].id, checkList: ModelData().checkLists[0] )
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
