//
//  EditSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 19/06/21.
//

import SwiftUI

struct EditSelection: View {
	@EnvironmentObject var modelData: ModelData
	var listEdit: Binding<EditMode>?
	
    var body: some View {
		NavigationView {
			List{
				ForEach(modelData.checkLists){ checkList in
					NavigationLink(
						destination: ListInfo(addSheet: .constant(false), listEdit: listEdit, checkList: checkList)
							.environmentObject(modelData)
							.onDisappear(){
								modelData.checkLists = modelData.checkLists.filter( {$0.id != CheckList.default.id})
							},
						tag: checkList.id,
						selection: $modelData.listSelector
					){
						ListRow(checkList: checkList)
					}
				}
				.onDelete(perform: { indexSet in
					modelData.checkLists.remove(atOffsets: indexSet)
				})
			}
			.navigationTitle("Edit Lists")
		}
    }
}

struct EditSelection_Previews: PreviewProvider {
    static var previews: some View {
		EditSelection(listEdit: .constant(EditMode.active))
			.environmentObject(ModelData())
    }
}
