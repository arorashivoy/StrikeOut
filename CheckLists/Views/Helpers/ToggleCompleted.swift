//
//  ToggleCompleted.swift
//  CheckLists
//
//  Created by Shivoy Arora on 16/06/21.
//

import SwiftUI

struct ToggleCompleted: View {
	@EnvironmentObject var modelData: ModelData
	var item: CheckList.Items
	var indexList: Int
	
    var body: some View {
		let index = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == item.id})
		
		Image(systemName: item.isCompleted ? "checkmark.circle.fill":"circle")
			.resizable()
			.frame(width: 25, height: 25, alignment: .center)
			.foregroundColor(item.isCompleted ? .blue:.gray)
			.onTapGesture(perform: {
				modelData.checkLists[indexList].items[index!].isCompleted.toggle()
			})
    }
}

struct ToggleCompleted_Previews: PreviewProvider {
    static var previews: some View {
		ToggleCompleted(item: ModelData().checkLists[0].items[0], indexList: 0)
			.environmentObject(ModelData())
    }
}
