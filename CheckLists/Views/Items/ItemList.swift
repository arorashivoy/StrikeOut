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
					ToggleCompleted(item: item, indexList: indexList)
						.environmentObject(modelData)
					
					Text(item.itemName)
						.foregroundColor(item.isCompleted ? .gray:.white)
						.padding()
					Spacer()
					
					if modelData.checkLists[indexList].showQuantity {
						
						Text("\(item.itemQuantity!)")
							.foregroundColor(.gray)
							.font(.subheadline)
							.padding()
					}
					
					
					Button{showInfo.toggle()} label: {
						Image(systemName: "info.circle")
							.resizable()
							.frame(width: 25, height: 25, alignment: .center)
							.foregroundColor(.blue)
						
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
			
			Button{
				newItem.toggle()
				modelData.checkLists[indexList].items.append(CheckList.Items.default)
				
			} label: {
				Image(systemName: "plus")
					.resizable()
					.frame(width: 20, height: 20, alignment: .leading)
					.foregroundColor(.blue)
			}
			.sheet(isPresented: $newItem) {
				ItemInfo(showInfo: $newItem, ID:CheckList.Items.default.id , checkList: checkList )
					.environmentObject(modelData)
//					.onAppear(){
//						modelData.checkLists[indexList].items.append(CheckList.Items.default)
//					}
					.onDisappear{
						modelData.checkLists[indexList].items = modelData.checkLists[indexList].items.filter( {$0.id != CheckList.Items.default.id})
					}
				
				
			}
		}
		.navigationTitle(checkList.listName)
	}
	
}

struct ItemList_Previews: PreviewProvider {
	static var previews: some View {
		ItemList(checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}
