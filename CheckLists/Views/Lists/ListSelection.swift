//
//  ListSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ListSelection: View {
	@EnvironmentObject var modelData: ModelData
	@State var addSheet: Bool = false
	
	var body: some View {
		NavigationView {
			List(){
				ForEach(modelData.checkLists){ checkList in
					NavigationLink(
						destination: ItemList(checkList: checkList).environmentObject(modelData),
						tag: checkList.id,
						selection: $modelData.listSelector
					){
						ListRow(checkList: checkList)
					}
				}
                
				Button{
					addSheet.toggle()
					modelData.checkLists.append(CheckList.default)
				}label: {
					Image(systemName: "plus")
						.resizable()
						.frame(width: 20, height: 20, alignment: .leading)
						.foregroundColor(.accentColor)
						.padding(.leading)
				}
				.sheet(isPresented: $addSheet, content: {
					ListInfo(addSheet: $addSheet, listEdit: .constant(EditMode.inactive), checkList: CheckList.default)
						.onDisappear(){
                            modelData.checkLists = modelData.checkLists.filter( {$0.id != CheckList.default.id})
						}
				})
			}
			.navigationTitle("Lists")
		}
	}
}

struct ListSelection_Previews: PreviewProvider {
	static var previews: some View {
        ListSelection()
			.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
			.environmentObject(ModelData())
    }
}
