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
    @State private var draftItem: CheckList.Items = CheckList.Items.default
    
	var checkList: CheckList
	
	var body: some View {
		
		let indexList = modelData.checkLists.firstIndex(where: {$0.id == checkList.id})!
		
        let filteredItems = filterItems(checkList: modelData.checkLists[indexList])
        
		List(){
			ForEach(filteredItems) { item in
				
				HStack{
                    
///                 Completed button
					ToggleCompleted(item: item, indexList: indexList)
						.environmentObject(modelData)
                    
///                 Item name
                    ItemName(item: item)
                    
					Spacer()
                    
///                 quantity
					if modelData.checkLists[indexList].showQuantity {
						
						Text("\(item.itemQuantity)")
							.foregroundColor(.gray)
							.font(.subheadline)
							.padding()
					}
					
///                 info button
					Button{
                        showInfo.toggle()
                        draftItem = item
                    } label: {
						Image(systemName: "info.circle")
							.resizable()
							.frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(modelData.checkLists[indexList].color)
						
					}
					.sheet(isPresented: $showInfo) {
                        ItemInfo(showInfo: $showInfo, draftItem: $draftItem, checkList: checkList)
							.environmentObject(modelData)
                        
					}
					
				}
			}
            
            ///Drag to delete
			.onDelete(perform: { indexSet in
                ///removing notification
                for i in indexSet {
                    AppNotification().remove(ID: modelData.checkLists[indexList].items[i].id)
                }
                
				modelData.checkLists[indexList].items.remove(atOffsets: indexSet)
			})
			
///         new item button
			Button{
				newItem.toggle()
                draftItem = CheckList.Items.default
				
			} label: {
				Image(systemName: "plus")
					.resizable()
					.frame(width: 20, height: 20, alignment: .leading)
                    .foregroundColor(modelData.checkLists[indexList].color)
			}
			.sheet(isPresented: $newItem) {
                ItemInfo(showInfo: $newItem, draftItem: $draftItem, checkList: checkList)
					.environmentObject(modelData)
				
			}
		}
		.listStyle(InsetGroupedListStyle())
		.navigationTitle(checkList.listName)
        .foregroundColor(modelData.checkLists[indexList].color)
        .toolbar{
            ///Menu
            ItemMenu(indexList: indexList)
                .environmentObject(modelData)
        }
	}
}

func filterItems(checkList: CheckList) -> [CheckList.Items] {
    if checkList.showCompleted {
        return checkList.items.filter{ !$0.isCompleted || !checkList.completedAtBottom } + checkList.items.filter{ $0.isCompleted && checkList.completedAtBottom }
    }else {
        return checkList.items.filter{ !$0.isCompleted }
    }
}

struct ItemList_Previews: PreviewProvider {
	static var previews: some View {
        ItemList(checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
	}
}
