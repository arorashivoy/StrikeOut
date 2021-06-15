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
	@State private var newItem: CheckList.Items = CheckList.Items.default
	
	var checkList: CheckList
	
	var indexList: Int?
	
	var body: some View {
		
		
		
		List(){
			let indexList = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
			let upper: Int = modelData.checkLists[indexList].items.count
			
			ForEach(0 ..< upper) {index in
				
				HStack{
					Image(systemName: modelData.checkLists[indexList].items[index].isCompleted ? "checkmark.circle.fill":"circle")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
						.foregroundColor(modelData.checkLists[indexList].items[index].isCompleted ? .blue:.gray)
						.onTapGesture(perform: {
							modelData.checkLists[indexList].items[index].isCompleted.toggle()
						})
					
					Text(modelData.checkLists[indexList].items[index].itemName)
						.foregroundColor(modelData.checkLists[indexList].items[index].isCompleted ? .gray:.white)
						.padding()
					Spacer()
					
					if modelData.checkLists[indexList].showQuantity {
						
						Text("\(modelData.checkLists[indexList].items[index].itemQuantity!)")
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
						ItemInfo(showInfo: $showInfo, item: $modelData.checkLists[indexList].items[index], checkList: checkList )
							.environmentObject(modelData)
					}
					
				}
				
			}
			
			Button{showInfo.toggle()} label: {
				Image(systemName: "plus")
					.resizable()
					.frame(width: 20, height: 20, alignment: .leading)
					.foregroundColor(.blue)
			}
			.sheet(isPresented: $showInfo) {
				ItemInfo(showInfo: $showInfo, item: $newItem, checkList: checkList )
					.environmentObject(modelData)
					.onDisappear{
						newItem = CheckList.Items.default
					}
			}
			.padding(.leading, 4.5)
			
			
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
