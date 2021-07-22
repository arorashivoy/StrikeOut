//
//  ItemList.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/06/21.
//

import SwiftUI

struct ItemList: View {
	@EnvironmentObject var modelData: ModelData
	@State private var showInfo: Bool = false
	@State private var newItem: Bool = false
	
	var checkList: CheckList
	
	
	var body: some View {
		
		let indexList = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		
		List(){
			ForEach(modelData.checkLists[indexList].items) { item in
				
				HStack{
                    
///                 Completed button
					ToggleCompleted(item: item, indexList: indexList)
						.environmentObject(modelData)
                    
///                 Item name
					Text(item.itemName)
						.foregroundColor(item.isCompleted ? .secondary:.primary)
						.padding()
					Spacer()
                    
///                 quantity
					if modelData.checkLists[indexList].showQuantity {
						
						Text("\(item.itemQuantity)")
							.foregroundColor(.gray)
							.font(.subheadline)
							.padding()
					}
					
///                 info button
					Button{showInfo.toggle()} label: {
						Image(systemName: "info.circle")
							.resizable()
							.frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(modelData.checkLists[indexList].color)
						
					}
					.sheet(isPresented: $showInfo) {
						ItemInfo(showInfo: $showInfo, ID: item.id, checkList: checkList)
							.environmentObject(modelData)
							.onDisappear(){
								
								modelData.checkLists[indexList].items = modelData.checkLists[indexList].items.filter( {$0.id != CheckList.Items.default.id})
								
							}
					}
					
				}
			}
			.onDelete(perform: { indexSet in
				modelData.checkLists[indexList].items.remove(atOffsets: indexSet)
			})
			
///         new item button
			Button{
				newItem.toggle()
				modelData.checkLists[indexList].items.append(CheckList.Items.default)
				
			} label: {
				Image(systemName: "plus")
					.resizable()
					.frame(width: 20, height: 20, alignment: .leading)
                    .foregroundColor(modelData.checkLists[indexList].color)
			}
			.sheet(isPresented: $newItem) {
				ItemInfo(showInfo: $newItem, ID:CheckList.Items.default.id , checkList: checkList )
					.environmentObject(modelData)
					.onDisappear{
						modelData.checkLists[indexList].items = modelData.checkLists[indexList].items.filter( {$0.id != CheckList.Items.default.id})
					}
				
				
			}
		}
//		.listStyle(InsetGroupedListStyle())
		.navigationTitle(checkList.listName)
        .foregroundColor(modelData.checkLists[indexList].color)
	}
}

struct ItemList_Previews: PreviewProvider {
	static var previews: some View {
		ItemList(checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}
