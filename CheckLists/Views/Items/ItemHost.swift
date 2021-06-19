//
//  ItemHost.swift
//  CheckLists
//
//  Created by Shivoy Arora on 17/06/21.
//

import SwiftUI

struct ItemHost: View {
	@Environment(\.editMode) var listEdit
	@EnvironmentObject var modelData: ModelData
	
	var checkList: CheckList
	
    var body: some View {
		VStack{
			if checkList.id != CheckList.default.id && listEdit?.wrappedValue == .inactive{
				
				ItemList(checkList: checkList)
					.environmentObject(modelData)
				
			}else {
				ListInfo(addSheet: .constant(false), checkList: checkList)
					.environmentObject(modelData)
					.onDisappear(){
						if modelData.checkLists.count < 1{
							listEdit?.wrappedValue = .active
						}
					}
			}
		}
		.padding()
		.navigationTitle(checkList.listName)
		.toolbar{
			EditButton()
		}
    }
}

struct ItemHost_Previews: PreviewProvider {
    static var previews: some View {
		ItemHost(checkList: ModelData().checkLists[0])
			.environmentObject(ModelData())
			.preferredColorScheme(.dark)
    }
}
