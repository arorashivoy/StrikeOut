//
//  ItemInfo.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemInfo: View {
	@EnvironmentObject var modelData: ModelData
    @AppStorage("compAsked") var compAsked: Bool = false
    @State private var compOption: Bool = false
	@Binding var showInfo: Bool
    @Binding var draftItem: CheckList.Items
	
    var indexList: Int
	
	var body: some View {
		
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
                if modelData.checkLists[indexList].showQuantity {
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
                        /// remove notification
                        AppNotification().remove(ID: draftItem.id)
                        
                        /// ask if you want to enable show notification
                        if !compAsked {
                            compOption = true
                        }
                    }
                }
                .sheet(isPresented: $compOption, content: {
                    CompletedOption(compOption: $compOption, indexList: indexList)
                        .environmentObject(modelData)
                })
                
                /// Flag
                Toggle(isOn: $draftItem.flagged, label: {
                    Text("Flag")
                })
                
///             Date and time
                DateSelection(dueDate: draftItem.dueDate ?? Date(),
                              dueTime: draftItem.dueDate ?? Date(), editItem: $draftItem, indexList: indexList)
                    .environmentObject(modelData)
                
			}
			.listStyle(DefaultListStyle())
            .frame(height: 180) // Hard coding frame to remove space that swiftui adds
            
            /// Notes text editor
            ItemNote(editItem: $draftItem)
                .environmentObject(modelData)
                .padding([.leading, .trailing])
                .padding(.top, 0)
            
///         Delete button
            DeleteItem(showInfo: $showInfo, ID: draftItem.id, indexList: indexList)
                .environmentObject(modelData)
            
		}
        .foregroundColor(modelData.checkLists[indexList].color)
		.padding()
		
	}
}

struct ItemInfo_Previews: PreviewProvider {
    @State static private var draftItem = ModelData().checkLists[0].items[0]
	static var previews: some View {
        ItemInfo(showInfo: .constant(true), draftItem: $draftItem, indexList: 0)
			.preferredColorScheme(.dark)
			.environmentObject(ModelData())
	}
}
